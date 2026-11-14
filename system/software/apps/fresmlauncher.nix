{ inputs, pkgs, ... }:
{
  environment.systemPackages = [
    inputs.freesmlauncher.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
