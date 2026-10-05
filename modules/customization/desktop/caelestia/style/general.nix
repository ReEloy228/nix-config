{ config, pkgs, inputs, ... }:
let
  inherit (inputs.caelestia-nixos.lib) sessionCommands use;
in {
  programs.caelestia.settings.general = {
    apps = {
      #audio    = [ "pavucontrol" ];
      playback = [ "mpv" ];
      explorer = [ "yazi" ];
      terminal = [ "foot" ];
    };
    idle = {
      inhibitWhenAudio = true;
      lockBeforeSleep  = true;
      timeouts = [
        { timeout = 480; idleAction = "lock"; }
        { timeout = 960; idleAction = "dpms off"; returnAction = "dpms on"; }
        { timeout = 1200; idleAction = sessionCommands.sleep; }
      ];
    };
  };
}
