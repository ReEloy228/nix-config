{ lib, pkgs, ... }:
{
  boot = {
    blacklistedKernelModules = [
      "snd_hda_codec_hdmi"
    ];

    kernel.sysctl = {
      "fs.inotify.max_user_watches" = lib.mkForce 524288;
      "fs.inotify.max_user_instances" = lib.mkForce 1024;
    };

    kernelPackages = pkgs.linuxPackages_latest;

    kernelParams = [
      "amdgpu.modeset=1"
      "quiet"
      "splash"
    ];

    initrd.systemd.enable = true;
    tmp.cleanOnBoot = true;
  };
}
