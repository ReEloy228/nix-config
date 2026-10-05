{ ... }:
{
  wayland.windowManager.hyprland.settings.bind = [
    "SUPER SHIFT, P, exec, hyprpicker -a"
    "SUPER, Print, exec, grim - | wl-copy"
    ", Print, exec, grim -g \"$(slurp)\" - | wl-copy"
  ];
}
