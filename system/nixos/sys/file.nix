{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    file
    libimobiledevice
    libirecovery
  ];
  services.usbmuxd = {
    enable = true;
    package = pkgs.usbmuxd2;
  };

  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="05ac", MODE="0660", GROUP="usbmux"
  '';

  services.gvfs.enable = true;
  services.tumbler.enable = true;
  programs.xfconf.enable = true;
}
