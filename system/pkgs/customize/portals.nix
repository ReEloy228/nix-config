{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
  ];

  environment.sessionVariables = {
    GTK_USE_PORTAL = "1";
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };
}
