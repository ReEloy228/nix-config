{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  nodejs_22,
  pkg-config,
  cairo,
  pango,
  libjpeg,
  giflib,
  librsvg,
  pixman,
  python3,
}:

let
  nodejs = nodejs_22;
  version = "1.4.6";

  pkg = fetchFromGitHub {
    owner = "xRyul";
    repo = "obsidian-image-converter";
    rev = version;
    hash = "sha256-Mc2v07CvCXtL8A+iBJJy7be9TABqQPhYfaBypgVT2Tk=i";
  };
in
buildNpmPackage.override { inherit nodejs; } (finalAttrs: {
  pname = "obsidian-image-converter";
  inherit version;
  src = pkg;

  npmDepsHash = "sha256-FOkEzlewYXUQ0OoaChf9iTy+sR4fiYrMQ2pU0J0rUAk=";

  nativeBuildInputs = [
    pkg-config
    python3
  ];

  buildInputs = [
    cairo
    pango
    libjpeg
    giflib
    librsvg
    pixman
  ];

  npmPackFlags = [ "--ignore-scripts" ];
  makeCacheWritable = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp ./build/main.js $out/main.js
    cp ./build/manifest.json $out/manifest.json
    cp ./build/styles.css $out/styles.css
    runHook postInstall
  '';

  meta = with lib; {
    description = "Convert, compress, resize, annotate, markup, draw, crop, rotate, flip, align images directly in Obsidian";
    homepage = "https://github.com/xRyul/obsidian-image-converter";
    license = licenses.mit;
    platforms = platforms.all;
  };
})
