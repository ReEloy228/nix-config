{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  libusb1,
  libimobiledevice,
  usbmuxd,
  zlib,
}:

stdenv.mkDerivation {
  pname = "palera1n";
  version = "2.0.2";
  src = fetchurl {
    url = "https://github.com/palera1n/palera1n/releases/download/v2.0.2/palera1n-linux-x86_64";
    hash = "sha256-6wGdLh2/PD7h+cGXxRYcKpQbIFJ6pVGIppD7HSjzxBg=";
  };
  nativeBuildInputs = [ autoPatchelfHook ];
  buildInputs = [
    libusb1
    libimobiledevice
    usbmuxd
    zlib
  ];
  sourceRoot = ".";
  dontUnpack = true;
  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/palera1n
    chmod +x $out/bin/palera1n
  '';
  meta = with lib; {
    description = "iOS jailbreak tool for checkm8 devices";
    homepage = "https://palera.in";
    license = licenses.gpl3Only;
    platforms = [ "x86_64-linux" ];
    mainProgram = "palera1n";
  };
}
