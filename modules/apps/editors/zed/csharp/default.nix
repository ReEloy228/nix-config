{
  lib,
  pkgs,
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
in
{
  home.packages = with pkgs; [
    csharp-ls-net10
    dotnet-sdk_10
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
}
