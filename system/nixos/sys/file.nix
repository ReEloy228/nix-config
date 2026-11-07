{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ file ];
  services.usbmuxd.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  programs.xfconf.enable = true;
}
