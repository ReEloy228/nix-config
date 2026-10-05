{ inputs, pkgs, ... }:
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  stylix = {
    base16Scheme = ./caelestia-theme.yaml;
    enable = true;
    autoEnable = false;
    polarity = "dark";

    targets.gnome.enable = true;
    targets.gtk.enable = true;

    opacity = {
      popups = 0.8;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      sizes.applications = 13;
    };
  };
}
