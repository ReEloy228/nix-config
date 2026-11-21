{
  appimageTools,
  fetchurl,
  lib,
}:

let
  pname = "kryoto-desktop";
  version = "0.3.11";

  src = fetchurl {
    url = "https://github.com/Kryoto-Dev/kryoto-desktop/releases/download/v${version}/Kryoto-Desktop_${version}_amd64.AppImage";
    hash = "sha256-YW3ND6h6/MCum9CaJJVX4jTYq8kONKH16t1/3R3twEY=";
  };

  appimageContents = appimageTools.extractType2 { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraInstallCommands = ''
    install -Dm444 "${appimageContents}/usr/share/applications/Kryoto Desktop.desktop" \
      $out/share/applications/kryoto-desktop.desktop

    if [ -d "${appimageContents}/usr/share/icons" ]; then
      cp -r ${appimageContents}/usr/share/icons $out/share/
    fi
  '';

  meta = with lib; {
    description = "Desktop client for Kryoto game library";
    homepage = "https://github.com/Kryoto-Dev/kryoto-desktop";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
