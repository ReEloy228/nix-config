{
  description = "Re Eloy Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    stylix.url = "github:nix-community/stylix/release-26.05";
    catppuccin.url = "github:catppuccin/nix";

    waydroid-script.url = "github:casualsnek/waydroid_script";

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    caelestia-cli = {
      url = "github:caelestia-dots/cli";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    caelestia-shell = {
      url = "github:caelestia-dots/shell";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.quickshell.follows = "quickshell";
      inputs.caelestia-cli.follows = "caelestia-cli";
    };
    caelestia-nixos = {
      url = "github:ReEloy228/caelestia-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    caelestia-stylix-sync.url = "github:ReEloy228/caelestia-stylix-sync";

    kopuz.url = "github:temidaradev/kopuz";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    nixcord = {
      url = "github:FlameFlag/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";
    base16-zed = {
      url = "github:bswinnerton/base16-zed";
      flake = false;
    };
    elegant-grub2-themes = {
      url = "github:vinceliuice/elegant-grub2-themes";
    };

    freesmlauncher = {
      url = "github:FreesmTeam/FreesmLauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      waydroid-script,
      nix-flatpak,
      stylix,
      catppuccin,
      quickshell,
      caelestia-cli,
      caelestia-shell,
      caelestia-nixos,
      caelestia-stylix-sync,
      zen-browser,
      nixcord,
      zapret-discord-youtube,
      elegant-grub2-themes,
      freesmlauncher,
      kopuz,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      overlays = [
        (final: prev: {
          caelestia-sync = caelestia-stylix-sync.packages.${system}.caelestia-sync;
        })
      ];
    in
    {
      packages.${system} = {
        palera1n = pkgs.callPackage ./external/palera1n.nix { };
      };

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit
            nixpkgs
            inputs
            self
            ;
        };
        modules = [
          ./configuration.nix
          {
            nixpkgs.overlays = overlays;
            home-manager.extraSpecialArgs = {
              obsidianPlugins = pkgs.callPackage ./external/obsidian { };
            };
          }
        ];
      };
    };
}
