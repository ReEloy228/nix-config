#!/usr/bin/env python3
"""
sync.py — синхронизация директории с /etc/nixos.

Использование:
    sudo python3 sync.py /path [опции]

Опции:
    --target DIR            Целевая директория (по умолчанию /etc/nixos)
    --ignore PAT [PAT ...]  Паттерны (gitignore-стиль) — полностью игнорировать
    --ignore-file FILE      Файл с паттернами ignore (по умолчанию /path/.ignore)
    --dontsync PAT [PAT...] Паттерны файлов, которые НЕ изменять в target
    --dontsync-file FILE    Файл с паттернами dontsync
    --dry-run               Ничего не менять, только показать план
    -v / -vv                INFO / DEBUG лог
    -q                      Только WARNING и выше
"""

import argparse
import fnmatch
import logging
import os
import shutil
import sys

DEFAULT_TARGET = "/etc/nixos"
DEFAULT_NEW_FILE_MODE = 0o644

logger = logging.getLogger("sync")


# ----------------------------------------------------------------------------
# Логирование
# ----------------------------------------------------------------------------
def setup_logging(verbosity: int, quiet: bool) -> None:
    if quiet:
        level = logging.WARNING
    elif verbosity == 0:
        level = logging.INFO
    elif verbosity == 1:
        level = logging.DEBUG
    else:
        level = logging.DEBUG  # -vv и выше = максимально подробно

    logging.basicConfig(
        level=level,
        format="%(asctime)s [%(levelname)-7s] %(message)s",
        datefmt="%H:%M:%S",
        stream=sys.stderr,
    )


# ----------------------------------------------------------------------------
# Паттерны (gitignore-подобные)
# ----------------------------------------------------------------------------
def match_pattern(rel_path: str, patterns) -> bool:
    """Проверить, соответствует ли относительный путь хоть одному паттерну.

    Правила:
      * Паттерн без '/' ищется по любому компоненту пути (как в .gitignore).
      * Паттерн со '/' применяется ко всему относительному пути.
      * '*' матчит '/' тоже (упрощение по сравнению с gitignore).
    """
    if not patterns:
        return False

    rel_path = rel_path.replace(os.sep, "/")

    for raw in patterns:
        pat = raw.strip()
        if not pat or pat.startswith("#"):
            continue
        pat = pat.rstrip("/")
        if not pat:
            continue

        if "/" not in pat:
            parts = rel_path.split("/")
            if any(fnmatch.fnmatch(part, pat) for part in parts):
                return True
        else:
            if fnmatch.fnmatch(rel_path, pat):
                return True
    return False


def load_patterns_file(path: str):
    patterns = []
    if not path or not os.path.isfile(path):
        return patterns
    try:
        with open(path, "r", encoding="utf-8") as f:
            for line in f:
                line = line.strip()
                if not line or line.startswith("#"):
                    continue
                patterns.append(line)
        logger.debug("Загружены паттерны из %s: %s", path, patterns)
    except OSError as e:
        logger.warning("Не удалось прочитать %s: %s", path, e)
    return patterns


# ----------------------------------------------------------------------------
# Обход директорий
# ----------------------------------------------------------------------------
def collect_files(base: str) -> dict:
    """Вернуть {относительный_путь: абсолютный_путь} для всех файлов в base."""
    result = {}
    if not os.path.isdir(base):
        return result
    for root, _dirs, files in os.walk(base):
        for f in files:
            full = os.path.join(root, f)
            if os.path.islink(full) and not os.path.exists(full):
                logger.debug("Битая симлинка, пропуск: %s", full)
                continue
            rel = os.path.relpath(full, base)
            result[rel] = full
    return result


# ----------------------------------------------------------------------------
# Утилиты
# ----------------------------------------------------------------------------
def files_equal(a: str, b: str) -> bool:
    """Построчное сравнение содержимого (chunked)."""
    try:
        if os.path.getsize(a) != os.path.getsize(b):
            return False
        with open(a, "rb") as fa, open(b, "rb") as fb:
            while True:
                ba = fa.read(65536)
                bb = fb.read(65536)
                if ba != bb:
                    return False
                if not ba:
                    return True
    except OSError as e:
        logger.debug("Сравнение не удалось (%s vs %s): %s", a, b, e)
        return False


def apply_perms(path: str, existing_stat=None, dry_run: bool = False) -> None:
    """Проставить права/владельца. Если existing_stat=None — 'новый файл root:root 644'."""
    if dry_run:
        return
    if existing_stat is not None:
        try:
            os.chmod(path, existing_stat.st_mode)
        except OSError as e:
            logger.warning("chmod не удался для %s: %s", path, e)
        try:
            os.chown(path, existing_stat.st_uid, existing_stat.st_gid)
        except (PermissionError, OSError) as e:
            logger.debug("chown (сохранение) не удался для %s: %s", path, e)
    else:
        try:
            os.chmod(path, DEFAULT_NEW_FILE_MODE)
        except OSError as e:
            logger.warning("chmod (default) не удался для %s: %s", path, e)
        try:
            os.chown(path, 0, 0)
        except (PermissionError, OSError) as e:
            logger.debug("chown root:root не удался для %s: %s", path, e)


def cleanup_empty_dirs(target: str, dry_run: bool = False) -> None:
    """Удалить пустые каталоги в target (снизу вверх), кроме самого target."""
    for root, _dirs, _files in os.walk(target, topdown=False):
        if os.path.abspath(root) == os.path.abspath(target):
            continue
        try:
            if not os.listdir(root):
                logger.debug("RMDIR: %s", root)
                if not dry_run:
                    os.rmdir(root)
        except OSError as e:
            logger.debug("Не удалось удалить каталог %s: %s", root, e)


# ----------------------------------------------------------------------------
# Основная логика
# ----------------------------------------------------------------------------
def sync(src: str, tgt: str, ignore_patterns, dontsync_patterns, dry_run: bool) -> None:
    src_files = {k: v for k, v in collect_files(src).items()
                 if not match_pattern(k, ignore_patterns)}
    tgt_files = {k: v for k, v in collect_files(tgt).items()
                 if not match_pattern(k, ignore_patterns)}

    logger.debug("Файлов в источнике (после ignore): %d", len(src_files))
    logger.debug("Файлов в цели (после ignore): %d", len(tgt_files))

    created = updated = deleted = skipped = unchanged = 0

    # --- 1. Копирование/обновление файлов из src -> tgt ---
    for rel, src_path in sorted(src_files.items()):
        if match_pattern(rel, dontsync_patterns):
            logger.info("SKIP (dontsync): %s", rel)
            skipped += 1
            continue

        tgt_path = os.path.join(tgt, rel)

        if rel in tgt_files:
            if files_equal(src_path, tgt_path):
                logger.debug("UNCHANGED: %s", rel)
                unchanged += 1
                continue

            try:
                st = os.stat(tgt_path)
            except OSError:
                st = None

            logger.info("UPDATE: %s", rel)
            if not dry_run:
                os.makedirs(os.path.dirname(tgt_path) or tgt, exist_ok=True)
                shutil.copyfile(src_path, tgt_path)
                apply_perms(tgt_path, existing_stat=st, dry_run=dry_run)
            updated += 1
        else:
            logger.info("CREATE: %s", rel)
            if not dry_run:
                os.makedirs(os.path.dirname(tgt_path) or tgt, exist_ok=True)
                shutil.copyfile(src_path, tgt_path)
                apply_perms(tgt_path, existing_stat=None, dry_run=dry_run)
            created += 1

    # --- 2. Удаление из tgt того, чего нет в src ---
    for rel, tgt_path in sorted(tgt_files.items()):
        if rel in src_files:
            continue
        if match_pattern(rel, dontsync_patterns):
            logger.info("SKIP DELETE (dontsync): %s", rel)
            skipped += 1
            continue

        logger.info("DELETE: %s", rel)
        if not dry_run:
            try:
                os.remove(tgt_path)
            except OSError as e:
                logger.error("Не удалось удалить %s: %s", tgt_path, e)
                continue
        deleted += 1

    # --- 3. Чистка пустых каталогов ---
    cleanup_empty_dirs(tgt, dry_run=dry_run)

    logger.info(
        "Итог: создано=%d, обновлено=%d, удалено=%d, пропущено(dontsync)=%d, без изменений=%d",
        created, updated, deleted, skipped, unchanged,
    )


# ----------------------------------------------------------------------------
# CLI
# ----------------------------------------------------------------------------
def parse_args(argv=None):
    p = argparse.ArgumentParser(
        description="Синхронизация директории в /etc/nixos (gitignore-стиль фильтров).",
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    p.add_argument("source", help="Исходная директория (например /path)")
    p.add_argument("--target", default=DEFAULT_TARGET,
                   help=f"Целевая директория (по умолчанию {DEFAULT_TARGET})")

    p.add_argument("--ignore", nargs="*", default=[], metavar="PATTERN",
                   help="Паттерны для полного игнорирования (не синхронизировать и не удалять)")
    p.add_argument("--ignore-file", default=None, metavar="FILE",
                   help="Файл со списком ignore-паттернов (по умолчанию <source>/.ignore)")

    p.add_argument("--dontsync", nargs="*", default=[], metavar="PATTERN",
                   help="Паттерны: файлы в target не изменять и не удалять")
    p.add_argument("--dontsync-file", default=None, metavar="FILE",
                   help="Файл со списком dontsync-паттернов")

    p.add_argument("--dry-run", action="store_true",
                   help="Ничего не менять, только показать план")
    p.add_argument("-v", "--verbose", action="count", default=0,
                   help="Увеличить подробность (-v INFO, -vv DEBUG)")
    p.add_argument("-q", "--quiet", action="store_true",
                   help="Только WARNING и выше")
    return p.parse_args(argv)


def main(argv=None) -> int:
    args = parse_args(argv)
    setup_logging(args.verbose, args.quiet)

    src = os.path.abspath(args.source)
    tgt = os.path.abspath(args.target)

    if not os.path.isdir(src):
        logger.error("Исходная директория не существует: %s", src)
        return 1

    if not os.path.isdir(tgt):
        logger.info("Создаю целевую директорию: %s", tgt)
        if not args.dry_run:
            try:
                os.makedirs(tgt, exist_ok=True)
            except OSError as e:
                logger.error("Не удалось создать %s: %s", tgt, e)
                return 1

    # --ignore: явные + из файла (по умолчанию <source>/.ignore)
    ignore_patterns = list(args.ignore)
    ignore_file = args.ignore_file or os.path.join(src, ".ignore")
    ignore_patterns += load_patterns_file(ignore_file)
    # сам .ignore не синхронизируем
    if ignore_file and os.path.abspath(ignore_file).startswith(src + os.sep):
        ignore_patterns.append(os.path.basename(ignore_file))

    # --dontsync: явные + из файла
    dontsync_patterns = list(args.dontsync)
    if args.dontsync_file:
        dontsync_patterns += load_patterns_file(args.dontsync_file)

    logger.debug("Source: %s", src)
    logger.debug("Target: %s", tgt)
    logger.debug("Ignore patterns: %s", ignore_patterns)
    logger.debug("Dontsync patterns: %s", dontsync_patterns)
    if args.dry_run:
        logger.info("Режим --dry-run: реальных изменений не будет")

    try:
        sync(src, tgt, ignore_patterns, dontsync_patterns, dry_run=args.dry_run)
    except PermissionError as e:
        logger.error("Недостаточно прав (запускать через sudo): %s", e)
        return 1
    except KeyboardInterrupt:
        logger.warning("Прервано пользователем")
        return 130

    return 0


if __name__ == "__main__":
    sys.exit(main())
