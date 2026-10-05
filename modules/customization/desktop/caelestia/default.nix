{
  inputs,
  lib,
  ...
}:
{
  imports = with inputs; [ caelestia-nixos.homeManagerModules.default ];
  disabledModules = [ "configs/editor/zed/config" ];

  programs.caelestia = {
    enable = true;
    cli.enable = true;
  };

  programs.caelestia-dots.caelestia.cli.enable = lib.mkDefault true;
  programs.caelestia-dots.term.fish.enable = lib.mkDefault true;
}
