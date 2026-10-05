{ lib
, pkgs
, config
, ...
}:

let
  # --- 1. Оверлей для csharp-ls под .NET 10 ---
  # Используем buildDotnetGlobalTool, чтобы собрать csharp-ls из NuGet-пакета
  # с указанием конкретного SDK. Это создаёт отдельный derivation,
  # который не конфликтует с dotnet-sdk_10 в home.packages.
  csharp-ls-net10 = pkgs.buildDotnetGlobalTool rec {
    pname = "csharp-ls";
    version = "0.24.0";

    # Хеш NuGet-пакета. Сначала используем fakeSha256,
    # чтобы получить правильный хеш (см. инструкцию ниже).
    nugetSha256 = "sha256-hpLTqgxwXiycfTaSd3nliS1quNB3VHLpSDBo+V18a9A=";

    # Явно указываем .NET 10 SDK и runtime.
    # Это ключевое отличие от версии в nixpkgs, которая собрана под .NET 8.
    dotnet-sdk = pkgs.dotnet-sdk_10;
    dotnet-runtime = pkgs.dotnet-sdk_10;

    meta = with lib; {
      description = "Roslyn-based LSP language server for C#";
      homepage = "https://github.com/razzmatazz/csharp-language-server";
      license = licenses.mit;
      maintainers = [ ];
      platforms = platforms.linux;
      mainProgram = "csharp-ls";
    };
  };

  # --- 2. Обёртка для Zed (исправление прав на расширения) ---
  csharpExtDir = "${config.home.homeDirectory}/.local/share/zed/extensions/work/csharp";
  zedBinary = lib.getExe pkgs.zed-editor;
  zedWrapper = pkgs.writeShellScriptBin "zed-fix" ''
    if [ -d "${csharpExtDir}" ]; then
      find "${csharpExtDir}" -type d -exec chmod u+rwx {} \;
      find "${csharpExtDir}" -type f -exec chmod u+rw {} \;
    fi
    exec ${zedBinary} "$@"
  '';

in
{
  # --- 3. Установка пакетов ---
  home.packages = with pkgs; [
    # Наш csharp-ls, собранный под .NET 10
    csharp-ls-net10

    # .NET 10 SDK для сборки вашего проекта (re-llama)
    dotnet-sdk_10

    # Обёртка для Zed
    zedWrapper
  ];

  # --- 4. Настройка Zed ---
  programs.zed-editor.userSettings = {
    # Указываем Zed, где искать бинарник csharp-ls.
    # lib.getExe разворачивает в полный путь в /nix/store.
    lsp.csharp-ls = {
      binary = {
        path = lib.getExe csharp-ls-net10;
      };
    };
  };

  # --- 5. Файлы для запуска Zed ---
  home.file.".local/bin/zed".source = "${zedWrapper}/bin/zed-fix";
  home.file.".local/share/applications/zed-fix.desktop".text = ''
    [Desktop Entry]
    Name=Zed [Fixed C#]
    Exec=${zedWrapper}/bin/zed-fix %F
    Icon=zed
    Type=Application
    Categories=Development;TextEditor;
    Terminal=false
    StartupWMClass=Zed
  '';
}
