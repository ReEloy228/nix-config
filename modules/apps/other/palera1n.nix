{ self, pkgs, ... }:
{
  home.packages = with self; [ packages.${pkgs.stdenv.hostPlatform.system}.palera1n ];
}
