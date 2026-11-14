{ lib, ... }:
{
  programs.obsidian.vaults."vault" = {
    enable = true;
    settings.appearance.baseFontSize = lib.mkForce 18;
  };

  stylix.targets.obsidian = {
    enable = true;
    vaultNames = [ "vault" ];
  };
}
