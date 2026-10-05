{ lib, pkgs, ... }:
let
  marketplaceExtensions = pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "vscode";
      publisher = "unoplatform";
      version = "0.24.1";
      sha256 = "sha256-s9ng53UFcl1MW0W7SErmqYwgOxK2iLLQohSggU9WgsQ=";
    }
  ];
  libPaths = lib.concatStringsSep ":" [
    "${pkgs.libx11}/lib"
    "${pkgs.icu}/lib"
    "${pkgs.gtk3}/lib"
    "${pkgs.libgdiplus}/lib"
    "${pkgs.alsa-lib}/lib"
    "${pkgs.pulseaudio}/lib"
    "${pkgs.ffmpeg}/lib"
    "${pkgs.fontconfig.lib}/lib"
    "${pkgs.libGL}/lib"
    "${pkgs.libdrm}/lib"
    "${pkgs.libxkbcommon}/lib"
    "${pkgs.freetype}/lib"
    "${pkgs.libXext}/lib"
    "${pkgs.libXfixes}/lib"
    "${pkgs.libXdamage}/lib"
    "${pkgs.libXxf86vm}/lib"
    "${pkgs.libXi}/lib"
    "${pkgs.libXrandr}/lib"
    "${pkgs.libXtst}/lib"
    "${pkgs.wayland}/lib"
    "${pkgs.libunwind}/lib"
    "/run/current-system/sw/lib"
  ];
  codeWrapper = pkgs.writeShellScriptBin "code-uno" ''
    export LD_LIBRARY_PATH="${libPaths}:$LD_LIBRARY_PATH"
    export GDK_BACKEND=x11
    exec ${pkgs.vscode}/bin/code "$@"
  '';
in
{
  programs.vscode.profiles.default = {
    extensions = marketplaceExtensions;

    userSettings = {
      "dotnetAcquisitionExtension.existingDotnetPath" = [
        {
          "extensionId" = "ms-dotnettools.csharp";
          "path" = "${pkgs.dotnet-sdk}/bin/dotnet";
        }
        {
          "extensionId" = "ms-dotnettools.csdevkit";
          "path" = "${pkgs.dotnet-sdk}/bin/dotnet";
        }
      ];
      "dotnetAcquisitionExtension.sharedExistingDotnetPath" = "${pkgs.dotnet-sdk}/bin/dotnet";
    };
  };

  home.packages = [ codeWrapper ];

  home.file.".local/share/applications/code-uno.desktop".text = ''
    [Desktop Entry]
    Name=Visual Studio Code [Fixed Uno Platform]
    Exec=${codeWrapper}/bin/code-uno %F
    Icon=vscode
    Type=Application
    Categories=Development;TextEditor;
    Terminal=false
    StartupWMClass=Code
  '';
}
