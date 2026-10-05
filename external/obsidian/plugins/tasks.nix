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
  version = "8.4.0";

  pkg = fetchFromGitHub {
    owner = "obsidian-tasks-group";
    repo = "obsidian-tasks";
    rev = version;
    hash = "sha256-8At6j4MuE08unH5ic90JqBl5y3R0/ply3M2nSUQwvBY=";
  };
in
stdenv.mkDerivation (finalAttrs: {
  pname = "obsidian-tasks";
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
    hash = "sha256-gdM+5S8u76HaGgXsaezXxibg4/p+OfXcuu3lZx9kvIk=";
  };

  yarnBuildScript = "build:dev";

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp ./main.js $out/main.js
    cp ./manifest.json $out/manifest.json
    cp ./styles.css $out/styles.css
    runHook postInstall
  '';

  meta = with lib; {
    description = "Task management for the Obsidian knowledge base";
    homepage = "https://github.com/obsidian-tasks-group/obsidian-tasks";
    license = licenses.mit;
    platforms = platforms.all;
  };
})
