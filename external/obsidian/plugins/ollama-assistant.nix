{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  nodejs_22,
}:

let
  nodejs = nodejs_22;
  version = "1.0.4";

  pkg = fetchFromGitHub {
    owner = "xlrve";
    repo = "ollama-assistant";
    rev = version;
    hash = "sha256-Plxhlqhbbty4+6Z4Yis4W6myP/BDO5iB3Lrcv3WYsTk=";
  };
in
buildNpmPackage.override { inherit nodejs; } (finalAttrs: {
  pname = "obsidian-ollama-assistant";
  inherit version;
  src = pkg;

  npmDepsHash = "sha256-bHBw64uXtlr08smEPR3sLhKdIaWPZc1WXOnI1uIzRfI=";

  npmPackFlags = [ "--ignore-scripts" ];
  makeCacheWritable = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp ./main.js $out/main.js
    cp ./manifest.json $out/manifest.json
    cp ./styles.css $out/styles.css
    runHook postInstall
  '';

  meta = with lib; {
    description = "Connect local AI via Ollama to Obsidian";
    homepage = "https://github.com/xlrve/ollama-assistant";
    license = licenses.mit;
    platforms = platforms.all;
  };
})
