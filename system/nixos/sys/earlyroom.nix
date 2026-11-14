{
  services.earlyoom = {
    enable = true;
    freeMemThreshold = 2;
    freeSwapThreshold = 2;

    extraArgs = [
      "-g"
      "--avoid"
      "^(X|Xorg|sshd|systemd|systemd-logind|nix-daemon|dbus-daemon|pipewire|wireplumber)$"
      "--prefer"
      "^(nix|nix-build|webkitgtk|electron|zen|firefox|discord)$"
    ];
  };
}
