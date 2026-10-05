{ pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  environment.systemPackages = with pkgs; [ lact ];
  systemd.packages = with pkgs; [ lact ];

  systemd.services.lactd = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
  };

  hardware.amdgpu.overdrive.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
}
