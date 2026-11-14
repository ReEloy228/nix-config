{ pkgs, ... }:
{
  programs.yazi.plugins = {
    "git" = {
      package = pkgs.yaziPlugins.git;
      setup = true;
    };

    "smart-enter" = pkgs.yaziPlugins.smart-enter;
    "smart-filter" = pkgs.yaziPlugins.smart-filter;
    "chmod" = pkgs.yaziPlugins.chmod;
    "toggle-pane" = pkgs.yaziPlugins.toggle-pane;
    "mount" = pkgs.yaziPlugins.mount;
    "wl-clipboard" = pkgs.yaziPlugins.wl-clipboard;
  };
}
