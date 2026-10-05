{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchPnpmDeps,
  pnpmConfigHook,
  pnpm_10,
  nodejs_22,
  git,
}:

let
  version = "4.1.4";

  pkg = fetchFromGitHub {
    owner = "PKM-er";
    repo = "obsidian-editing-toolbar";
    rev = version;
    hash = "sha256-nK0+ghsVMa3Aneq4k+4tfRbQdeEj+izVDaem5io12VY=";
  };
in
stdenv.mkDerivation (finalAttrs: {
  pname = "obsidian-editing-toolbar";
  inherit version;
  src = pkg;

  nativeBuildInputs = [
    nodejs_22
    pnpm_10
    pnpmConfigHook
    git
  ];

  pnpmDeps = fetchPnpmDeps {
    inherit (finalAttrs) pname version src;
    pnpm = pnpm_10;
    fetcherVersion = 3;
    hash = "sha256-8SXmWmWhciEyJqriJw4lrF2F/tbLIXOU5VtlST0+l/4=";
  };

  buildPhase = ''
    runHook preBuild
    pnpm run build
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp ./Editing-Toolbar-Test-Vault/.obsidian/plugins/editing-toolbar/main.js $out/main.js
    cp ./Editing-Toolbar-Test-Vault/.obsidian/plugins/editing-toolbar/styles.css $out/styles.css
    cp ./manifest.json $out/manifest.json
    runHook postInstall
  '';

  meta = with lib; {
    description = "An Obsidian toolbar plugin, modified from the Cmenu plugin";
    homepage = "https://github.com/PKM-er/obsidian-editing-toolbar";
    license = licenses.mit;
    platforms = platforms.all;
  };
})
