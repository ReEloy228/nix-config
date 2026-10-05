{ ... }:
{
  services.displayManager.sddm = {
    enable = false;
    wayland.enable = true;
  };
}
