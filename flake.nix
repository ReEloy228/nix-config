{
  description = "Re Eloy Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:nix-community/stylix/release-26.05";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    waydroid-script.url = "github:casualsnek/waydroid_script";
    zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";

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
      url = "github:reeloy228/caelestia-nixos";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    caelestia-stylix-sync.url = "github:ReEloy228/caelestia-stylix-sync";

    hyprKCS = {
      url = "github:kosa12/hyprKCS";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    serein = {
      url = "github:ViceVerse-cz/Serein";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    freesmlauncher = {
      url = "github:FreesmTeam/FreesmLauncher";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    kopuz.url = "github:temidaradev/kopuz";

    artcraft-nix = {
      url = "github:ipeglin/artcraft-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    effectcraft = {
      url = "github:storytold/effectcraft";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      rust-overlay,
      stylix,
      nix-flatpak,
      waydroid-script,
      zapret-discord-youtube,
      quickshell,
      caelestia-cli,
      caelestia-shell,
      caelestia-nixos,
      caelestia-stylix-sync,
      hyprKCS,
      zen-browser,
      serein,
      freesmlauncher,
      kopuz,
      artcraft-nix,
      effectcraft,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      overlays = [
        inputs.rust-overlay.overlays.default
        inputs.artcraft-nix.overlays.default
        (final: prev: {
          caelestia-sync = caelestia-stylix-sync.packages.${system}.caelestia-sync;

          soundcloud-desktop = final.callPackage ./external/soundcloud-desktop.nix { };
          palera1n = final.callPackage ./external/palera1n.nix { };
          v2raya = final.callPackage ./external/v2raya.nix { };
          yt-dlp = final.callPackage ./external/yt-dlp.nix { };

          word-craft = final.callPackage ./external/art-craft/word-craft.nix { };

          photocraft = final.artcraft.photocraft;
          effectcraft = final.artcraft.effectcraft;

          serein = prev.serein.override (
            oldAttrs:
            let
              rustToolchain = final.rust-bin.stable.latest.default;
              newRustPlatform = final.makeRustPlatform {
                cargo = rustToolchain;
                rustc = rustToolchain;
              };
            in
            {
              rustPlatform = newRustPlatform;
            }
          );

          kryoto-desktop = final.callPackage ./external/kryoto-desktop.nix { };
        })
      ];

      pkgs = import nixpkgs { inherit system overlays; };

    in
    {
      packages.${system} = {
        inherit (pkgs)
          v2raya
          photocraft
          effectcraft
          word-craft
          palera1n
          kryoto-desktop
          soundcloud-desktop
          ;
      };

      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit nixpkgs inputs self;
        };
        modules = [
          ./configuration.nix
          {
            nixpkgs.overlays = overlays;
            home-manager.extraSpecialArgs = {
              inherit inputs;
              obsidianPlugins = pkgs.callPackage ./external/obsidian { };
            };
          }
        ];
      };
    };
}
