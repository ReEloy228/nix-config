{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    virt-manager
    virt-viewer
    dmg2img
  ];
}
