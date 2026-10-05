{ pkgs, ... }:
{
  programs.fish.enable = true;

  home.packages = with pkgs.fishPlugins; [
    bass
    fzf-fish
  ];

  stylix.targets.fish.enable = true;
}
