{ ... }:
{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        pad = "8x8";
        term = "xterm-256color";
      };
      mouse = {
        hide-when-typing = "yes";
      };
    };
  };

  stylix.targets.foot.enable = true;
}
