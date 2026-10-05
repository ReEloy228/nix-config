{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ ventoy-full ];
  nixpkgs.config.permittedInsecurePackages = [ "ventoy-1.1.12" ];
}
