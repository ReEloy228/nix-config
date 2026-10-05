{ pkgs, ... }:
{
  programs.yazi.plugins = {
    "smart-enter" = pkgs.yaziPlugins.smart-enter;
    "smart-filter" = pkgs.yaziPlugins.smart-filter;
    "chmod" = pkgs.yaziPlugins.chmod;
    "full-border" = pkgs.yaziPlugins.full-border;
    "git" = pkgs.yaziPlugins.git;
    "toggle-pane" = pkgs.yaziPlugins.toggle-pane;
    "glow" = pkgs.yaziPlugins.glow;
    "mount" = pkgs.yaziPlugins.mount;
  };
}
