{
  inputs,
  lib,
  ...
}:
let
  inherit (inputs.caelestia-nixos.lib) sessionCommands;
in
{
  programs.caelestia.settings.general = {
    apps = {
      playback = lib.mkForce [ "mpv" ];
      explorer = lib.mkForce [ "yazi" ];
      terminal = lib.mkForce [ "foot" ];
    };
    idle = {
      inhibitWhenAudio = lib.mkForce true;
      lockBeforeSleep = lib.mkForce true;
      timeouts = lib.mkForce [
        {
          timeout = 480;
          idleAction = "lock";
        }
        {
          timeout = 960;
          idleAction = "dpms off";
          returnAction = "dpms on";
        }
        {
          timeout = 1200;
          idleAction = sessionCommands.sleep;
        }
      ];
    };
  };
}
