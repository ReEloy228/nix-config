{ ... }:
{
  wayland.windowManager.hyprland.settings.bind = [
    "SUPER SHIFT, P, exec, hyprpicker -a"
    "SHIFT, Print, exec, caelestia screenshot"
    ", Print, exec, grim -g \"$(slurp)\" - | wl-copy"
  ];
}
