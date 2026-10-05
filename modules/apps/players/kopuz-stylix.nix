{ config, pkgs, ... }:
let
  colors = config.lib.stylix.colors;
  tomlFormat = pkgs.formats.toml { };

  kopuzTheme = {
    name = "Stylix";
    vars = {
      bg = "#${colors.base00}";
      surface = "#${colors.base01}";
      raised = "#${colors.base02}";
      accent-deep = "#${colors.base03}";

      text = "#${colors.base05}";
      text-muted = "#${colors.base04}";

      accent = "#${colors.base0D}";
      accent-alt = "#${colors.base0C}";
      accent-soft = "#${colors.base0E}";
      highlight = "#${colors.base0A}";
      highlight-dark = "#${colors.base09}";
      progress = "#${colors.base0B}";
      danger = "#${colors.base08}";
    };
  };

  kopuzSettings = {
    theme = "stylix";
    custom_themes.stylix = kopuzTheme;

    language = "en";
    music_directory = [ "/home/user/Music" ];
    volume = 0.61;
  };
in
{
  xdg.configFile."kopuz/settings.toml".source =
    tomlFormat.generate "kopuz-settings.toml" kopuzSettings;
}
