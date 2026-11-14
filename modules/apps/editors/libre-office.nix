{ pkgs, ... }:
{
  home.packages = with pkgs; [ libreoffice-qt6-fresh ];

  home.sessionVariables = {
    SAL_USE_VCLPLUGIN = "qt6";
  };
}
