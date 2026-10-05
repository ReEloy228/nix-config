{
  lib,
  stdenv,
  fetchFromGitHub,
  makeWrapper,
  bash,
  sudo,
  coreutils,
  gnused,
  gnugrep,
}:

stdenv.mkDerivation {
  pname = "waydroid-total-spoof";
  version = "unstable-2025-08-18";

  src = fetchFromGitHub {
    owner = "lil-xhris";
    repo = "Waydroid-total-spoof";
    rev = "main";
    sha256 = "sha256-nTqUmwvuwDHNGUw1qDII6EgA5yQIty+mURw1aABybVQ=";
  };

  nativeBuildInputs = [ makeWrapper ];

  sourceRoot = ".";
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    mkdir -p $out/share/waydroid-total-spoof
    cp -r ./* $out/share/waydroid-total-spoof/

    for script in waydroid.sh V2.0.sh; do
      if [ -f "$out/share/waydroid-total-spoof/$script" ]; then
        makeWrapper ${bash}/bin/bash $out/bin/waydroid-total-spoof-''${script%.sh} \
          --add-flags "$out/share/waydroid-total-spoof/$script" \
          --prefix PATH : ${
            lib.makeBinPath [
              sudo
              coreutils
              gnused
              gnugrep
            ]
          }
      fi
    done

    runHook postInstall
  '';

  meta = with lib; {
    description = "Tool for spoofing Waydroid device properties";
    homepage = "https://github.com/lil-xhris/Waydroid-total-spoof";
    license = licenses.mit;
    platforms = platforms.linux;
    mainProgram = "waydroid-total-spoof-V2.0";
  };
}
