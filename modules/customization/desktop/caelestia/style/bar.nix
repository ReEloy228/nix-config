{ ... }:
{
  programs.caelestia.settings.bar = {
    statusIcons = [
      { id = "lockStatus"; enabled = true; }
      { id = "audio"; enabled = true; }
      { id = "microphone"; enabled = true; }
      { id = "kbLayout"; enabled = false; }
      { id = "network"; enabled = true; }
      { id = "bluetooth"; enabled = true; }
      { id = "battery"; enabled = false; }
    ];
    tray = {
      background = false;
      compact    = false;
      iconSubs   = [];
      recolour   = true;
     };
  };
}
