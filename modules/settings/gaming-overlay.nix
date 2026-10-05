{ lib, pkgs, ... }:
{
  home.packages = with pkgs; [
    mangohud
    goverlay
  ];

  home.sessionVariables = {
    MANGOHUD_WSI = "wayland";
    QT_QPA_PLATFORM = "wayland";
  };

  home.activation.notifyGamingOverlay = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    echo "Gaming overlay (home) enabled."
    echo "MangoHud and GOverlay installed in user environment."
    echo "Wayland: MANGOHUD_WSI=wayland, QT_QPA_PLATFORM=wayland"
  '';
}
