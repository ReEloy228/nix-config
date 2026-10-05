{ ... }:
{
  programs.yazi = {
    enable = true;
    shellWrapperName = "yy";
  };

  stylix.targets.yazi.enable = true;
}
