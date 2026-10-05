{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchPnpmDeps,
  pnpmConfigHook,
  pnpm_10,
  nodejs_22,
}:

let
  version = "0.23.2";

  pkg = fetchFromGitHub {
    owner = "tgrosinger";
    repo = "advanced-tables-obsidian";
    rev = version;
    hash = "sha256-LvjTv6vrP4N/+w4OdoiOkSO9wCB7yYhH3MtjlK5L0J4=";
  };
in
stdenv.mkDerivation (finalAttrs: {
  pname = "obsidian-advanced-tables";
  inherit version;
  src = pkg;

  nativeBuildInputs = [
    nodejs_22
    pnpm_10
    pnpmConfigHook
  ];

  pnpmDeps = fetchPnpmDeps {
    inherit (finalAttrs) pname version src;
    pnpm = pnpm_10;
    fetcherVersion = 3;
    hash = "sha256-D04aNgSrRR5zyZl96OiJgEPmg+Z/yuyVMVf/z72S1RA=";
  };

  buildPhase = ''
    runHook preBuild
    pnpm run build
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp ./main.js $out/main.js
    cp ./manifest.json $out/manifest.json
    cp ./styles.css $out/styles.css
    runHook postInstall
  '';

  meta = with lib; {
    description = "Improved table navigation, formatting, and manipulation in Obsidian";
    homepage = "https://github.com/tgrosinger/advanced-tables-obsidian";
    license = licenses.gpl3;
    platforms = platforms.all;
  };
})
