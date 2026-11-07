{
  lib,
  pkgs,
  config,
  ...
}:

let
  csharp-ls-net10 = pkgs.buildDotnetGlobalTool rec {
    pname = "csharp-ls";
    version = "0.24.0";
    nugetSha256 = "sha256-hpLTqgxwXiycfTaSd3nliS1quNB3VHLpSDBo+V18a9A=";

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
  home.packages = with pkgs; [
    csharp-ls-net10
    dotnet-sdk_10
    zedWrapper
  ];

  programs.zed-editor.userSettings = {
    languages.CSharp.language_servers = [
      "csharp-ls"
      "!roslyn"
      "!omnisharp"
    ];
    lsp.csharp-ls = {
      binary = {
        path = lib.getExe csharp-ls-net10;
      };
    };
  };

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
