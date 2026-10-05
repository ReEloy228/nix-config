{ inputs, ... }:
{
  imports = [ inputs.elegant-grub2-themes.nixosModules.default ];

  boot.loader.elegant-grub2-theme = {
    enable = true;
    theme = "mojave";
    type = "window";
    side = "right";
    color = "dark";
    screen = "1080p";
    logo = "system";
  };
}
