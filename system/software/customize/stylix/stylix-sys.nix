{
  inputs,
  pkgs,
  ...
}:
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  stylix = {
    base16Scheme = ./caelestia-theme.yaml;
    enable = true;
    autoEnable = false;
    polarity = "dark";

    targets.gnome.enable = true;
    targets.gtk.enable = true;

    opacity.popups = 0.8;

    cursor = {
      package = pkgs.apple-cursor;
      name = "macOS";
      size = 26;
    };

    icons = {
      enable = true;
      package = pkgs.reversal-icon-theme;
      light = "Reversal";
      dark = "Reversal-dark";
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

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
