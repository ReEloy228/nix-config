{ pkgs, ... }:
{
  home.packages = with pkgs; [ fuzzel ];
  stylix.targets.fuzzel.enable = true;
}
