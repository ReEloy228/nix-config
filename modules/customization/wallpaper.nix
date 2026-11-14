{ pkgs, ... }:
let
  wpSrc = pkgs.fetchFromGitHub {
    owner = "iruzo";
    repo = "wp";
    rev = "90903c6610032c0341558080fe058c2f38c81cab";
    sha256 = "sha256-qh7L6ignAjmyi+JZVW6KD8bxmg9yuPd5G0r7qoM/hyI";
  };

  rootEntries = builtins.readDir wpSrc;
  imageNames = builtins.filter (n: rootEntries.${n} == "regular") (builtins.attrNames rootEntries);
in
{
  home.file = builtins.listToAttrs (
    map (name: {
      name = "Pictures/Wallpapers/${name}";
      value = {
        source = "${wpSrc}/${name}";
      };
    }) imageNames
  );
}
