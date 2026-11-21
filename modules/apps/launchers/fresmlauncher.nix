{ inputs, pkgs, ... }:
{
  home.packages = [
    inputs.freesmlauncher.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
