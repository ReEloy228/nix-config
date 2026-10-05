{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:

let
  version = "2.12.4";

  pkg = fetchFromGitHub {
    owner = "zsviczian";
    repo = "obsidian-excalidraw-plugin";
    rev = version;
    hash = "sha256-mnNNv9U918h8ZDyyi/ZBH/BsaBCpLKHAn5hscmxL/Xg=";
  };

  mathjaxToSVG = buildNpmPackage {
    pname = "obsidian-excalidraw-mathjax-to-svg";
    inherit version;
    src = pkg;

    npmDepsHash = "sha256-x8ToewyXv9JmYxLOhH99huRkKvbtkWvM07vYqA2R5C0=";
    npmPackFlags = [ "--ignore-scripts" ];

    preBuild = ''
      cd MathjaxToSVG
    '';
    installPhase = ''
      runHook preInstall
      mkdir -p $out/lib
      cp $NIX_BUILD_TOP/source/MathjaxToSVG/dist/* $out/lib/
      runHook postInstall
    '';
  };
in
buildNpmPackage (finalAttrs: {
  pname = "obsidian.plugins.excalidraw";
  inherit version;
  src = pkg;

  npmDepsHash = "sha256-x8ToewyXv9JmYxLOhH99huRkKvbtkWvM07vYqA2R5C0=";
  npmPackFlags = [ "--ignore-scripts" ];
  makeCacheWritable = true;

  preBuild = ''
    mkdir -p MathjaxToSVG/dist
    cp -r ${mathjaxToSVG}/lib/* MathjaxToSVG/dist/
  '';

  configurePhase = ''
    runHook preConfigure
    export MATHJAX_TO_SVG_PATH="${mathjaxToSVG}/lib"
    runHook postConfigure
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp ./dist/manifest.json $out/manifest.json
    cp ./dist/main.js $out/main.js
    cp ./dist/styles.css $out/styles.css
    runHook postInstall
  '';

  meta = with lib; {
    description = "Edit and view Excalidraw drawings in Obsidian";
    homepage = "https://github.com/zsviczian/obsidian-excalidraw-plugin";
    license = licenses.mit;
    platforms = platforms.all;
  };
})
