{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ os-prober ];

  boot.loader = {
    systemd-boot.enable = true;
    refind.enable = false;
    grub = {
      enable = false;
      devices = [ "nodev" ];
      efiSupport = true;
      efiInstallAsRemovable = false;
      enableCryptodisk = false;
      useOSProber = true;
      copyKernels = true;
    };

    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
  };
}
