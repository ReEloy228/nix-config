{
  inputs,
  ...
}:
let
  inherit (inputs.caelestia-nixos.lib) sessionCommands;
in
{
  programs.caelestia-dots.caelestia.shell.settings.general = {
    apps = {
      playback.__override = [ "mpv" ];
      explorer.__override = [ "yazi" ];

      terminal.__override = [ "foot" ];
    };
    idle = {
      inhibitWhenAudio = true;
      lockBeforeSleep = true;
      timeouts.__override = [
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
