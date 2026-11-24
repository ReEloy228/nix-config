{ ... }:
{
  documentation.nixos.enable = true;
  nixpkgs.config.allowUnfree = true;
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
    settings = {
      build-dir = "/nix/var/nix/tmp";
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      extra-substituters = [
        "https://kopuz.cachix.org"
      ];
      extra-trusted-public-keys = [
        "kopuz.cachix.org-1:J2X3AnAYhKTJW5S3aCLoA1ckonQXVNZMQvhZA0YAufw="
      ];
    };
  };
}
