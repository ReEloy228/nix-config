{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hyprpicker
    grim
    slurp
    swappy
    wl-clipboard
  ];
}
