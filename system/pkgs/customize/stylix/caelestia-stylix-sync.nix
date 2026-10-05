{ inputs, ... }:
{ 
  imports = [ inputs.caelestia-stylix-sync.nixosModules.default ];
  services.caelestia-stylix-sync = {
    enable = true;
    user = "user"; 
    themeFile = "/etc/nixos/system/pkgs/customize/stylix/caelestia-theme.yaml";
    generateWith = "base";
    logLevel = "Debug";
    pollingInterval = 3;
  };
}
