{
  config,
  lib,
  pkgs,
  ...
}:

let
  extensionsDir = "${config.home.homeDirectory}/.local/share/zed/extensions/installed";
  extensionName = "zed-netcoredbg";

  extensionSrc = pkgs.fetchFromGitHub {
    owner = "qwadrox";
    repo = "zed-netcoredbg";
    rev = "main";
    hash = "sha256-61pLcqtW2ZyqRE7NrASYHDeyyUaDclmFJMu97hYj+xE=";
  };

  installExtension = pkgs.writeShellScript "install-zed-netcoredbg" ''
    set -e
    mkdir -p "${extensionsDir}/${extensionName}"
    cp -r ${extensionSrc}/* "${extensionsDir}/${extensionName}/"
    chmod -R u+w "${extensionsDir}/${extensionName}"
    echo "Extension ${extensionName} installed to ${extensionsDir}/${extensionName}"
  '';

in
{
  home.packages = with pkgs; [
    netcoredbg
    (rust-bin.stable.latest.default.override {
      targets = [ "wasm32-wasip2" ];
    })
    gcc
    binutils
    lld
  ];

  home.sessionPath = [
    "${pkgs.gcc}/bin"
    "${pkgs.binutils}/bin"
    "${pkgs.lld}/bin"
  ];

  home.sessionVariables = {
    CC = "${pkgs.gcc}/bin/gcc";
    CXX = "${pkgs.gcc}/bin/g++";
  };

  home.file.".cargo/config.toml".text = ''
    [target.x86_64-unknown-linux-gnu]
    rustflags = ["-C", "link-arg=-fuse-ld=lld"]
  '';

  home.activation.installZedNetCoreDbg = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    ${installExtension}
  '';

  programs.zed-editor = {
    userSettings = {
      dap = {
        netcoredbg = {
          binary = "${pkgs.netcoredbg}/bin/netcoredbg";
        };
      };
    };
  };

  home.file.".config/zed/debug-template.json".text = ''
    [
      {
        "label": "Debug .NET Core App",
        "adapter": "netcoredbg",
        "request": "launch",
        "program": "''${ZED_WORKTREE_ROOT}/bin/Debug/net10.0/YourProject.dll",
        "cwd": "''${ZED_WORKTREE_ROOT}",
        "build": {
          "command": "dotnet",
          "args": ["build", "''${ZED_WORKTREE_ROOT}/YourProject.csproj", "-p:Configuration=Debug"]
        }
      }
    ]
  '';

  home.file.".config/zed/debug-readme.txt".text = ''
    Для настройки отладки в проекте:
    1. Copy debug-template.json to .zed/debug.json
    2. Adjust the paths for your project (.dll name, .NET version, .csproj name).
    3. Set a breakpoint and press F5.
  '';
}
