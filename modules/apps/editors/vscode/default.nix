{ pkgs, ... }:
{
  home.packages = with pkgs; [ vscode ];

  stylix.targets.vscode = {
    enable = true;
    profileNames = [ "default" ];
  };

  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;

    profiles.default = {
      enableUpdateCheck = false;

      extensions = with pkgs.vscode-extensions; [ continue.continue ];

      userSettings = {
        "debug.onTaskErrors" = "abort";
        "debug.breakpointsView.presentation" = "tree";
        "explorer.confirmDragAndDrop" = "false";
      };
    };
  };
}
