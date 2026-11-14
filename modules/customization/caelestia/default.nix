{
  inputs,
  lib,
  ...
}:
{
  imports = with inputs; [ caelestia-nixos.homeManagerModules.default ];

  programs.caelestia = {
    enable = true;
    cli.enable = true;
  };

  programs.caelestia-dots = {
    caelestia.shell.enable = lib.mkDefault true;
    caelestia.cli.enable = lib.mkDefault true;
    term.fish.enable = lib.mkDefault true;
    editor = {
      zed.enable = lib.mkForce false;
      vscode.enable = lib.mkForce false;
    };
    foot.enable = lib.mkForce false;
    btop.enable = lib.mkForce false;
  };
}
