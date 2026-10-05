{ pkgs, ... }:
{
  environment = {
    systemPackages = with pkgs; [ phinger-cursors ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      XCURSOR_THEME = "phinger-cursors-light";
      XCURSOR_SIZE = "24";
    };
  };
}
