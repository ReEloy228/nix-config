{ ... }:
{
  programs.caelestia-dots.caelestia.shell.settings.bar = {
    tray.recolour = true;

    statusIcons.__override = [
      {
        id = "lockStatus";
        enabled = true;
      }
      {
        id = "audio";
        enabled = true;
      }
      {
        id = "microphone";
        enabled = true;
      }
      {
        id = "bluetooth";
        enabled = true;
      }
      {
        id = "network";
        enabled = true;
      }
      {
        id = "kbLayout";
        enabled = false;
      }
      {
        id = "battery";
        enabled = false;
      }
    ];
  };
}
