{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    mangohud
    goverlay
  ];

  environment.sessionVariables = {
    MANGOHUD_WSI = "wayland";
    QT_QPA_PLATFORM = "wayland";
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  system.activationScripts.gaming-overlay-notice = ''
    echo "Gaming overlay (system) enabled."
    echo "MangoHud and GOverlay installed."
    echo "Wayland: MANGOHUD_WSI=wayland, QT_QPA_PLATFORM=wayland"
    echo "Use 'mangohud %command%' in Steam or run 'mangohud <app>'"
    echo "Configure with 'goverlay'"
  '';
}
