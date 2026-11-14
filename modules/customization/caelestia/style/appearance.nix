{ lib, ... }:
{
  programs.caelestia.settings.appearance = {
    anim.durations.scale = lib.mkForce 1.75;
    transparency = {
      enabled = lib.mkForce true;
      base = lib.mkForce 0.8;
      layers = lib.mkForce 0.55;
    };
  };
}
