{ ... }:
{
  imports = [
    ./hardware-configuration.nix
  ]
  ++ (import ./import.nix);

  system.stateVersion = "25.11";
}
