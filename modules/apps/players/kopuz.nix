{ inputs, pkgs, ... }:
{
  home.packages = [ inputs.kopuz.packages.${pkgs.stdenv.hostPlatform.system}.default ];
}
