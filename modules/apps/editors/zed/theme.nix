{
  config,
  pkgs,
  ...
}:

let
  colors = config.lib.stylix.colors;
  themeName = "Stylix";
  themeFile = ".config/zed/themes/${themeName}.json";

  c = key: "#${colors.${key}}";

  themeJson = pkgs.writeText "zed-theme.json" (
    builtins.toJSON {
      "$schema" = "https://zed.dev/schema/themes/v0.1.0.json";
      name = "base16";
      author = "Stylix";
      themes = [
        {
          name = themeName;
          appearance = "dark";
          style = {
            border = c "base02";
            "border.variant" = c "base02";
            "border.focused" = null;
            "border.selected" = null;
            "border.transparent" = null;
            "border.disabled" = null;
            "elevated_surface.background" = c "base00";
            "surface.background" = c "base00";
            background = c "base00";
            "element.background" = c "base01";
            "element.hover" = c "base02";
            "element.active" = null;
            "element.selected" = c "base02";
            "element.disabled" = null;
            "drop_target.background" = c "base02";
            "ghost_element.background" = null;
            "ghost_element.hover" = c "base01";
            "ghost_element.active" = null;
            "ghost_element.selected" = c "base02";
            "ghost_element.disabled" = null;
            text = c "base05";
            "text.muted" = c "base04";
            "text.placeholder" = c "base07";
            "text.disabled" = c "base02";
            "text.accent" = c "base0C";
            icon = null;
            "icon.muted" = null;
            "icon.disabled" = null;
            "icon.placeholder" = null;
            "icon.accent" = null;
            "status_bar.background" = c "base00";
            "title_bar.background" = c "base00";
            "title_bar.inactive_background" = c "base01";
            "toolbar.background" = c "base00";
            "tab_bar.background" = c "base00";
            "tab.inactive_background" = c "base01";
            "tab.active_background" = c "base00";
            "search.match_background" = c "base02";
            "panel.background" = c "base00";
            "panel.focused_border" = c "base02";
            "pane.focused_border" = null;
            "scrollbar.thumb.background" = c "base02";
            "scrollbar.thumb.hover_background" = c "base03";
            "scrollbar.thumb.border" = "${c "base02"}6f";
            "scrollbar.track.background" = c "base00";
            "scrollbar.track.border" = null;
            "editor.foreground" = c "base05";
            "editor.background" = c "base00";
            "editor.gutter.background" = c "base00";
            "editor.subheader.background" = c "base00";
            "editor.active_line.background" = c "base01";
            "editor.highlighted_line.background" = null;
            "editor.line_number" = c "base03";
            "editor.active_line_number" = c "base06";
            "editor.invisible" = null;
            "editor.wrap_guide" = c "base01";
            "editor.active_wrap_guide" = c "base03";
            "editor.document_highlight.read_background" = c "base01";
            "editor.document_highlight.write_background" = c "base01";
            "terminal.background" = c "base00";
            "terminal.foreground" = null;
            "terminal.bright_foreground" = null;
            "terminal.dim_foreground" = null;
            "terminal.ansi.black" = c "base00";
            "terminal.ansi.bright_black" = c "base03";
            "terminal.ansi.dim_black" = null;
            "terminal.ansi.red" = c "base08";
            "terminal.ansi.bright_red" = c "base08";
            "terminal.ansi.dim_red" = null;
            "terminal.ansi.green" = c "base0B";
            "terminal.ansi.bright_green" = c "base0B";
            "terminal.ansi.dim_green" = null;
            "terminal.ansi.yellow" = c "base0A";
            "terminal.ansi.bright_yellow" = c "base0A";
            "terminal.ansi.dim_yellow" = null;
            "terminal.ansi.blue" = c "base0D";
            "terminal.ansi.bright_blue" = c "base0D";
            "terminal.ansi.dim_blue" = null;
            "terminal.ansi.magenta" = c "base0E";
            "terminal.ansi.bright_magenta" = c "base0E";
            "terminal.ansi.dim_magenta" = null;
            "terminal.ansi.cyan" = c "base0C";
            "terminal.ansi.bright_cyan" = c "base0C";
            "terminal.ansi.dim_cyan" = null;
            "terminal.ansi.white" = c "base05";
            "terminal.ansi.bright_white" = c "base07";
            "terminal.ansi.dim_white" = null;
            "link_text.hover" = c "base0C";
            conflict = c "base0A";
            "conflict.background" = c "base00";
            "conflict.border" = c "base0A";
            created = c "base0B";
            "created.background" = c "base00";
            "created.border" = c "base0B";
            deleted = c "base08";
            "deleted.background" = c "base00";
            "deleted.border" = c "base08";
            error = c "base08";
            "error.background" = c "base00";
            "error.border" = c "base08";
            hidden = c "base03";
            "hidden.background" = c "base00";
            "hidden.border" = c "base03";
            hint = c "base05";
            "hint.background" = c "base00";
            "hint.border" = c "base0C";
            ignored = c "base03";
            "ignored.background" = c "base00";
            "ignored.border" = c "base03";
            info = c "base0C";
            "info.background" = c "base00";
            "info.border" = c "base0C";
            modified = c "base0D";
            "modified.background" = c "base00";
            "modified.border" = c "base0D";
            predictive = c "base03";
            "predictive.background" = c "base01";
            "predictive.border" = c "base02";
            renamed = c "base0A";
            "renamed.background" = c "base00";
            "renamed.border" = c "base0A";
            success = c "base0B";
            "success.background" = c "base00";
            "success.border" = c "base0B";
            unreachable = c "base0A";
            "unreachable.background" = c "base00";
            "unreachable.border" = c "base0A";
            warning = c "base0A";
            "warning.background" = c "base00";
            "warning.border" = c "base0A";
            players = [
              {
                cursor = c "base05";
                selection = c "base02";
                background = null;
              }
            ];
            syntax = {
              attribute = {
                color = c "base0D";
                font_style = null;
                font_weight = null;
              };
              boolean = {
                color = c "base09";
                font_style = null;
                font_weight = null;
              };
              comment = {
                color = c "base03";
                font_style = "italic";
                font_weight = null;
              };
              "comment.doc" = {
                color = c "base03";
                font_style = "italic";
                font_weight = null;
              };
              constant = {
                color = c "base09";
                font_style = null;
                font_weight = null;
              };
              constructor = {
                color = c "base08";
                font_style = null;
                font_weight = null;
              };
              emphasis = {
                color = c "base08";
                font_style = "italic";
                font_weight = null;
              };
              "emphasis.strong" = {
                color = c "base08";
                font_style = null;
                font_weight = 700;
              };
              function = {
                color = c "base0D";
                font_style = null;
                font_weight = null;
              };
              keyword = {
                color = c "base0E";
                font_style = null;
                font_weight = null;
              };
              label = {
                color = c "base0A";
                font_style = null;
                font_weight = null;
              };
              link_text = {
                color = c "base08";
                font_style = null;
                font_weight = null;
              };
              link_uri = {
                color = c "base08";
                font_style = null;
                font_weight = null;
              };
              number = {
                color = c "base09";
                font_style = null;
                font_weight = null;
              };
              punctuation = {
                color = c "base05";
                font_style = null;
                font_weight = null;
              };
              "punctuation.bracket" = {
                color = c "base05";
                font_style = null;
                font_weight = null;
              };
              "punctuation.delimiter" = {
                color = c "base05";
                font_style = null;
                font_weight = null;
              };
              "punctuation.list_marker" = {
                color = c "base05";
                font_style = null;
                font_weight = null;
              };
              "punctuation.special" = {
                color = c "base05";
                font_style = null;
                font_weight = null;
              };
              string = {
                color = c "base0B";
                font_style = null;
                font_weight = null;
              };
              "string.escape" = {
                color = c "base09";
                font_style = null;
                font_weight = null;
              };
              "string.regex" = {
                color = c "base0B";
                font_style = null;
                font_weight = null;
              };
              "string.special" = {
                color = c "base0B";
                font_style = null;
                font_weight = null;
              };
              "string.special.symbol" = {
                color = c "base0B";
                font_style = null;
                font_weight = null;
              };
              tag = {
                color = c "base08";
                font_style = null;
                font_weight = null;
              };
              "text.literal" = {
                color = c "base0B";
                font_style = null;
                font_weight = null;
              };
              title = {
                color = c "base0A";
                font_style = null;
                font_weight = null;
              };
              type = {
                color = c "base0A";
                font_style = null;
                font_weight = null;
              };
              variable = {
                color = c "base08";
                font_style = null;
                font_weight = null;
              };
              "variable.special" = {
                color = c "base08";
                font_style = "italic";
                font_weight = null;
              };
            };
          };
        }
      ];
    }
  );

in
{
  programs.zed-editor = {
    userSettings = {
      theme = themeName;
      buffer_font_family = config.stylix.fonts.monospace.name;
      buffer_font_size = config.stylix.fonts.sizes.terminal * 4.0 / 3.0;
      ui_font_family = config.stylix.fonts.sansSerif.name;
      ui_font_size = config.stylix.fonts.sizes.applications * 4.0 / 3.0;
    };
  };

  home.file."${themeFile}".source = themeJson;
}
