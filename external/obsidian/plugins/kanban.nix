{
  lib,
  stdenv,
  fetchFromGitHub,
  fetchYarnDeps,
  yarn,
  yarnConfigHook,
  yarnBuildHook,
  nodejs_22,
}:

let
  nodejs = nodejs_22;
  version = "2.0.51";

  pkg = fetchFromGitHub {
    owner = "mgmeyers";
    repo = "obsidian-kanban";
    rev = version;
    hash = "sha256-NahypggwPrub2KxRBAn54ZpEInP1V+6l/xmUKUt6myA=";
  };
in
stdenv.mkDerivation (finalAttrs: {
  pname = "obsidian-kanban";
  inherit version;
  src = pkg;

  nativeBuildInputs = [
    nodejs
    yarn
    yarnConfigHook
    yarnBuildHook
  ];

  offlineCache = fetchYarnDeps {
    yarnLock = finalAttrs.src + "/yarn.lock";
    hash = "sha256-eof2W9Ja4RlmjQ0SnaF/jadHX3GRkCRrMwZU2z0M/Jk=";
  };

  yarnBuildScript = "build";

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp ./manifest.json $out/manifest.json
    cp ./main.js $out/main.js
    cp ./styles.css $out/styles.css
    runHook postInstall
  '';

  meta = with lib; {
    description = "Create markdown-backed Kanban boards in Obsidian";
    homepage = "https://github.com/mgmeyers/obsidian-kanban";
    license = licenses.gpl3;
    platforms = platforms.all;
  };
})
