{ pkgs, ... }:
{
  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-extensions; [ jnoortheen.nix-ide ];
    userSettings = {
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "nix.formatterPath" = "nixpkgs-fmt";
    };
  };
}
