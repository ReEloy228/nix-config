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
          timeout = 1440;
          idleAction = "lock";
        }
        {
          timeout = 2400;
          idleAction = "dpms off";
          returnAction = "dpms on";
        }
        {
          timeout = 3600;
          idleAction = sessionCommands.sleep;
        }
      ];
    };
  };
}
