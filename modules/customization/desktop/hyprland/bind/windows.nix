{ ... }:
{
  wayland.windowManager.hyprland.settings.bind = [
    "SUPER, Q, killactive"
    "SUPER, F, fullscreen"
    "SUPER, V, togglefloating"
    "SUPER, M, exec, hyprctl dispatch setfloating; hyprctl dispatch toggleminimize"

    "SUPER, H, movefocus, l"
    "SUPER, J, movefocus, d"
    "SUPER, K, movefocus, u"
    "SUPER, L, movefocus, r"

    "SUPER SHIFT, H, movewindow, l"
    "SUPER SHIFT, J, movewindow, d"
    "SUPER SHIFT, K, movewindow, u"
    "SUPER SHIFT, L, movewindow, r"

    "SUPER CTRL, H, resizeactive, -20 0"
    "SUPER CTRL, L, resizeactive, 20 0"
    "SUPER CTRL, K, resizeactive, 0 -20"
    "SUPER CTRL, J, resizeactive, 0 20"
  ];
}
