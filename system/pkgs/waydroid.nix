{
  self,
  pkgs,
  inputs,
  ...
}:
{
  virtualisation.waydroid.enable = true;

  virtualisation.waydroid.package = pkgs.waydroid-nftables;

  networking.firewall.trustedInterfaces = [ "waydroid0" ];
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward" = 1;
    "net.ipv4.conf.all.forwarding" = 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };

  environment.systemPackages = [
    inputs.waydroid-script.packages.${pkgs.stdenv.hostPlatform.system}.waydroid_script
    pkgs.waydroid-helper
    self.packages.${pkgs.stdenv.hostPlatform.system}.waydroid-total-spoof
  ];
}
