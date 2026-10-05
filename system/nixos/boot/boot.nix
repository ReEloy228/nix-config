{ pkgs, ... }:
{
  boot = {
    blacklistedKernelModules = [ "snd_hda_codec_hdmi" ];
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
