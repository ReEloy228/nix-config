{ ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "hyprlang";

    systemd.enable = true;
    xwayland.enable = true;
  };
}
