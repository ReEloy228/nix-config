{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ file ];
  services.usbmuxd.enable = true;
}
