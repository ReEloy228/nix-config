{ ... }:
{
  home.stateVersion = "25.11";
  programs.home-manager.enable = true;

  home.sessionVariables = {
    XCURSOR_THEME = "phinger-cursors-light";
    XCURSOR_SIZE = "24";
    TERMINAL = "foot";
  };
}
