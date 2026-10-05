{ inputs, pkgs, ... }:
{
  imports = [ inputs.zen-browser.homeModules.beta ];
  home.packages = with pkgs; [ libayatana-appindicator ];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
  };

  stylix.targets.zen-browser = {
    enable = true;
    profileNames = [ "default" ];
  };
}
