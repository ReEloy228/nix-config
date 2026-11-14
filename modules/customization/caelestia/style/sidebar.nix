{ lib, ... }:
{
  programs.caelestia.settings.sidebar.dragThreshold = lib.mkForce 65;
}
