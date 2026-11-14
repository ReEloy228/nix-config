{ pkgs, ... }:
{
  security.pam.loginLimits = [
    {
      domain = "*";
      type = "soft";
      item = "memlock";
      value = "unlimited";
    }
    {
      domain = "*";
      type = "hard";
      item = "memlock";
      value = "unlimited";
    }
  ];

  systemd.settings.Manager = {
    DefaultLimitMEMLOCK = "infinity";
  };

  boot.kernelModules = [ "kvm" ];
  boot.extraModprobeConfig = ''
    options kvm ignore_msrs=1
  '';
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
    };
  };

  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  users.users.user.extraGroups = [
    "libvirtd"
    "kvm"
  ];

  services.udev.extraRules = ''
    SUBSYSTEM=="vfio", OWNER="root", GROUP="kvm", MODE="0660"
    SUBSYSTEM=="kvm", OWNER="root", GROUP="kvm", MODE="0660"
  '';

  environment.systemPackages = with pkgs; [
    dnsmasq
    virt-viewer
  ];
}
