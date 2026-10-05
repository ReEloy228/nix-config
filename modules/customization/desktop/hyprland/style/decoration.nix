{ ... }:
{
  wayland.windowManager.hyprland.settings = {
  decoration = {
    rounding = 16;
    active_opacity = 0.80;
    inactive_opacity = 0.55;
    blur = {
      enabled = true;
      size = 5;
      passes = 2;
    };
    shadow = {
      enabled = false;
      range = 10;
      render_power = 3;
    };
  };

  layerrule = [
    "blur on, ignore_alpha 0, animation popin, match:namespace launcher"
  ];
};
}
