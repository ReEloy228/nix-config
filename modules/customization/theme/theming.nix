{ pkgs, ... }:
{
  home.packages = with pkgs; [ papirus-icon-theme ];

  gtk = {
    enable = true;
    iconTheme = {
      name = "Dracula";
      package = pkgs.dracula-icon-theme;
    };
  };
}
