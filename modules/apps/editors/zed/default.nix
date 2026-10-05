{ pkgs, ... }:
{
  home.packages = with pkgs; [
    zed-editor
    nil
    nixd
    nodejs
  ];

  programs.zed-editor = {
    enable = true;

    userSettings = {
      vim_mode = false;

      agent.dock = "right";
      project_panel.dock = "left";
      search.button = false;
      outline_panel.dock = "left";
      git_panel.dock = "left";

      lsp.nil.settings.nix.flake.autoArchive = false;
    };
  };
}
