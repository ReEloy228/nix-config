{ pkgs, inputs, ... }:
{
  home.packages = [
    inputs.hyprKCS.packages.${pkgs.system}.default
  ];
}
