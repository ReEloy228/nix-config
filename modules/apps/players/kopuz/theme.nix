{ config, lib, ... }:
let
  colors = config.lib.stylix.colors;
in
{
  config = lib.mkIf config.programs.kopuz.enable {
    programs.kopuz.settings = {
      theme = "stylix";
      custom_themes.stylix = {
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
    };
  };
}
