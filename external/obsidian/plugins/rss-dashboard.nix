{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  nodejs_22,
  git,
}:

let
  nodejs = nodejs_22;
  version = "2.6.0";

  pkg = fetchFromGitHub {
    owner = "amatya-aditya";
    repo = "obsidian-rss-dashboard";
    rev = version;
    hash = "sha256-Cc1UyLyHxRrg49K+6VIzayWlmRFoSCMHzUdZXioaVc8=";
  };
in
buildNpmPackage.override { inherit nodejs; } (finalAttrs: {
  pname = "obsidian-rss-dashboard";
  inherit version;
  src = pkg;

  npmDepsHash = "sha256-T8LM67Zz3/0mhHSbr2eHeeFHZavxuUAf+Fa2A26M0oA=";

  nativeBuildInputs = [ git ];

  preBuild = ''
    export GIT_CONFIG_GLOBAL=/dev/null
    export GIT_CONFIG_SYSTEM=/dev/null
    git init -q
    git add -A
    git -c user.email=nix@localhost -c user.name=nix commit -qm "nix"
  '';

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
    description = "A Dashboard for organizing and consuming RSS feeds, YouTube channels, and podcasts";
    homepage = "https://github.com/amatya-aditya/obsidian-rss-dashboard";
    license = licenses.mit;
    platforms = platforms.all;
  };
})
