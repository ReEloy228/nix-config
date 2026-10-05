{ inputs, self, ... }:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = { inherit inputs self; };
  };

  programs.hyprland = {
    enable = true;
    withUWSM = false;
    xwayland.enable = true;
  };
}
