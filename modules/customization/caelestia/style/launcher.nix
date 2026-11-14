{ lib, ... }:
{
  programs.caelestia.settings.launcher = {
    useFuzzy = {
      actions = lib.mkForce true;
      apps = lib.mkForce true;
      schemes = lib.mkForce true;
      variants = lib.mkForce true;
      wallpapers = lib.mkForce true;
    };
  };
}
