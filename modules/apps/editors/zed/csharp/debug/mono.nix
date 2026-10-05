{
  config,
  lib,
  pkgs,
  ...
}:

let
  extensionsDir = "${config.home.homeDirectory}/.local/share/zed/extensions/installed";
  extensionName = "unity-engine-ex";

  extensionSrc = pkgs.fetchFromGitHub {
    owner = "Namey5";
    repo = "zed-unity-extension";
    rev = "main";
    hash = "sha256-tv6Ysysz96+slfGQmjTPT3roQzmuUoutJPETUmat+04=";
  };

  installExtension = pkgs.writeShellScript "install-zed-unity-extension" ''
    set -e
    mkdir -p "${extensionsDir}/${extensionName}"
    cp -r ${extensionSrc}/* "${extensionsDir}/${extensionName}/"
    chmod -R u+w "${extensionsDir}/${extensionName}"
    echo "Extension ${extensionName} installed to ${extensionsDir}/${extensionName}"
  '';

in
{
  home.packages = with pkgs; [
    mono
  ];

  home.activation.installZedUnityExtension = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    ${installExtension}
  '';

  programs.zed-editor = {
    userSettings = {
      dap = {
        UnityDAP = {
          binary = "${pkgs.mono}/bin/mono";
        };
      };
    };
  };

  home.file.".config/zed/debug-template-unity.json".text = ''
    [
      {
        "label": "Attach to Unity (Mono)",
        "adapter": "UnityDAP",
        "request": "attach",
        "monoPath": "${pkgs.mono}/bin/mono",
        "address": "127.0.0.1",
        "port": 56000,
        "logLevel": "warn"
      }
    ]
  '';

  home.file.".config/zed/debug-readme-unity.txt".text = ''
    Отладка Unity через Mono (расширение Unity Engine):

    1. Убедитесь, что расширение Unity Engine установлено в Zed
       (оно копируется автоматически при home-manager switch).

    2. Включите Editor Attaching в Unity:
       Edit → Preferences → General → Editor Attaching

    3. Запустите Unity с вашим проектом и дождитесь полной загрузки.

    4. Найдите PID главного процесса Unity:
       pgrep -f "Unity -projectpath /путь/к/вашему/проекту"
       (обратите внимание на -projectpath с маленькой буквы — это главный процесс,
        воркеры импорта используют -projectPath с большой P и не подходят)

    5. Вычислите порт отладчика Unity по формуле:
       port = 56000 + (PID % 1000)
       Пример: PID = 81327 → port = 56000 + 327 = 56327

    6. Скопируйте debug-template-unity.json в .zed/debug.json в корне проекта:
       mkdir -p /путь/к/проекту/.zed
       cp ~/.config/zed/debug-template-unity.json /путь/к/проекту/.zed/debug.json

    7. Откройте .zed/debug.json и замените значение "port" на вычисленное.

    8. Запустите отладку в Zed (F5) и выберите конфигурацию "Attach to Unity (Mono)".

    Примечание: PID Unity меняется при каждом перезапуске редактора,
    поэтому порт нужно пересчитывать заново.
  '';
}
