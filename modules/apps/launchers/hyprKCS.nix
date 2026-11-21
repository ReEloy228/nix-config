{ pkgs, inputs, ... }:
{
  home.packages = [
    inputs.hyprKCS.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
