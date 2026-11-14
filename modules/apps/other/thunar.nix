{ pkgs, ... }:

{
  home.packages = with pkgs; [
    thunar
    thunar-archive-plugin
    thunar-volman
    xfconf
    tumbler
    xfce4-exo
    gvfs
  ];

  stylix.targets.gtk.enable = true;

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "thunar.desktop";
    };
  };

  xdg.portal = {
    enable = true;
    config = {
      common."org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
    };
  };
}
