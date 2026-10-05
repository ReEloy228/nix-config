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
  version = "1.5.10";

  pkg = fetchFromGitHub {
    owner = "liamcain";
    repo = "obsidian-calendar-plugin";
    rev = version;
    hash = "sha256-SQtr2ZI5MecyNYS40okR+uEirww4GZz9WmQObv7ffNc=";
  };
in
stdenv.mkDerivation (finalAttrs: {
  pname = "obsidian-calendar";
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
    hash = "sha256-YvJbiMU+1tQ6V9MCiICCxaShvDfCNtXy0AqOt73vCz0=";
  };

  yarnBuildScript = "build";

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp ./main.js $out/main.js
    cp ./manifest.json $out/manifest.json
    cp ./styles.css $out/styles.css
    runHook postInstall
  '';

  meta = with lib; {
    description = "Calendar view of your daily notes";
    homepage = "https://github.com/liamcain/obsidian-calendar-plugin";
    license = licenses.mit;
    platforms = platforms.all;
  };
})
