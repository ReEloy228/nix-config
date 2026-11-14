{ lib, ... }:
{
  programs.caelestia.settings.bar = {
    tray.recolour = lib.mkForce true;
    statusIcons = lib.mkForce [
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
