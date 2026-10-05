{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  nodejs_22,
}:

let
  nodejs = nodejs_22;
  version = "1.30.0";

  pkg = fetchFromGitHub {
    owner = "platers";
    repo = "obsidian-linter";
    rev = version;
    hash = "sha256-pqbCt5h1KXwe2wXoF8v9xj3ntKcWwClQrcO6RHQa5QY=";
  };
in
buildNpmPackage.override { inherit nodejs; } (finalAttrs: {
  pname = "obsidian-linter";
  inherit version;
  src = pkg;

  npmDepsHash = "sha256-6VgGl27vYunzU3QvPT4ljFtG/7RxhmrUPQZHE7eGepo=";

  npmPackFlags = [ "--ignore-scripts" ];
  makeCacheWritable = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp ./main.js $out/main.js
    cp ./manifest.json $out/manifest.json
    runHook postInstall
  '';

  meta = with lib; {
    description = "Formats and styles your notes with a focus on configurability and extensibility";
    homepage = "https://github.com/platers/obsidian-linter";
    license = licenses.mit;
    platforms = platforms.all;
  };
})
