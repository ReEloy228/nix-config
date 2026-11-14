{
  appimageTools,
  fetchurl,
}:

let
  pname = "palera1n";
  version = "3.0.0-beta.3";

  src = fetchurl {
    url = "https://github.com/palera1n/palera1n/releases/download/v${version}/palera1n-linux-x86_64.AppImage";
    hash = "sha256-ixBHgCYGgbSka6JORJaIaKVEJkBE+OlWctf+quSLRWM=";
  };

in
appimageTools.wrapType2 {
  inherit pname version src;
}
