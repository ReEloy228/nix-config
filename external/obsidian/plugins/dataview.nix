{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  runCommand,
  jq,
  nodejs_22,
  git,
}:

let
  nodejs = nodejs_22;
  version = "0.5.70";

  githubSrc = fetchFromGitHub {
    owner = "blacksmithgu";
    repo = "obsidian-dataview";
    rev = version;
    hash = "sha256-qz2Un5r4bZyX0mZ7J7Yvd/gSWKn/GxUUrC7OF2jTL3c=";
  };
in
buildNpmPackage.override { inherit nodejs; } (finalAttrs: {
  pname = "obsidian-dataview";
  inherit version;

  nativeBuildInputs = [ git ];

  forceGitDeps = true;
  makeCacheWritable = true;

  src =
    runCommand "${finalAttrs.pname}-${finalAttrs.version}-src"
      {
        nativeBuildInputs = [ jq ];
      }
      ''
        cp -r --no-preserve=mode,ownership ${githubSrc} $out
        chmod -R +w $out

        jq '
          ( .dependencies // {} )
            |= if has("@codemirror/language")
               then ."@codemirror/language" = "git+https://github.com/karaolidis/cm-language.git#package-lock"
               else . end
          | ( .devDependencies // {} )
            |= if has("@codemirror/language")
               then ."@codemirror/language" = "git+https://github.com/karaolidis/cm-language.git#package-lock"
               else . end
        ' $out/package.json > $out/package.json.tmp
        mv $out/package.json.tmp $out/package.json

        jq '
          walk(
            if type == "object" and (.resolved? | type == "string")
               and (.resolved | test("cm-language"))
            then .resolved = "git+https://github.com/karaolidis/cm-language.git#package-lock"
            else . end
          )
        ' $out/package-lock.json > $out/package-lock.json.tmp
        mv $out/package-lock.json.tmp $out/package-lock.json
      '';

  npmDepsHash = "sha256-8hDBO+FVVVvpUXOX/zw3A0MV0HCIDGKt5OUUZPiSa24=";

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp ./manifest.json $out/manifest.json
    cp ./build/main.js $out/main.js
    cp ./styles.css $out/styles.css
    runHook postInstall
  '';

  meta = with lib; {
    description = "Complex query language for Obsidian";
    homepage = "https://github.com/blacksmithgu/obsidian-dataview";
    license = licenses.mit;
    platforms = platforms.all;
  };
})
