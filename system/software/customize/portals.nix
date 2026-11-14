{ pkgs, ... }:
{
  services.dbus.enable = true;
  security.rtkit.enable = true;

  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
  ];

  environment.sessionVariables = {
    GTK_USE_PORTAL = "1";
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };
}
