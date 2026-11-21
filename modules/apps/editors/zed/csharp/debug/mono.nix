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
    Debugging Unity via Mono (Unity Engine extension):

    1. Make sure the Unity Engine extension is installed in Zed (it is copied automatically during the home-manager switch).
    2. Enable Editor Attaching in Unity: Edit → Preferences → General → Editor Attaching
    3. Launch Unity with your project and wait for it to load completely.
    4. Find the PID of the Unity main process: pgrep -f "Unity -projectpath /path/to/your/project" (note that -projectpath with a lowercase is the main process, import workers use -projectPath with a large P and are not suitable)
    5. Calculate the Unity debugger port using the formula: port = 56000 + (PID % 1000) Example: PID = 81327 → port = 56000 + 327 = 56327
    6. Copy the debug-template-unity.json to.zed/debug.json at the root of the project: mkdir -p /path/to/project/.zed cp ~/.config/zed/debug-template-unity.json /path/to/project/.zed/debug.json
    7. Open.zed/debug.json and replace the "port" value with the calculated value.
    8. Run debugging in Zed (F5) and select the "Attach to Unity (Mono)" configuration.

    Note: Unity's PID changes every time the editor is restarted, Therefore, the port needs to be recalculated.
  '';
}
