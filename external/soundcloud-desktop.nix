{
  lib,
  pkgs ? import <nixpkgs> { },
}:

let
  pname = "soundcloud-desktop";
  version = "9.0.0";

  src = pkgs.fetchurl {
    url = "https://github.com/zxcloli666/SoundCloud-Desktop/releases/download/${version}/soundcloud-desktop_${version}_amd64.AppImage";
    hash = "sha256-ToIUb47v0K9KoXzhqxLid/BpFI0vTogcVBE1akyF+y0=";
  };

  appimageContents = pkgs.appimageTools.extractType2 {
    inherit pname version src;
  };
in
pkgs.appimageTools.wrapType2 {
  inherit pname version src;

  extraPkgs =
    pkgs: with pkgs; [
      webkitgtk_4_1
      libsoup_3
      glib
      gtk4
      libayatana-appindicator
      alsa-lib
      opus
      ffmpeg
      gst_all_1.gstreamer
      gst_all_1.gst-plugins-base
      gst_all_1.gst-plugins-good
      gst_all_1.gst-plugins-bad
    ];

  extraInstallCommands = ''
    install -Dm644 ${appimageContents}/soundcloud-desktop.desktop $out/share/applications/soundcloud-desktop.desktop
    install -Dm644 ${appimageContents}/soundcloud-desktop.png $out/share/icons/hicolor/128x128/apps/soundcloud-desktop.png

    substituteInPlace $out/share/applications/soundcloud-desktop.desktop \
      --replace-warn 'Exec=soundcloud-desktop' 'Exec=${pname}'
  '';

  meta = with pkgs.lib; {
    description = "Unofficial SoundCloud desktop client";
    homepage = "https://github.com/zxcloli666/SoundCloud-Desktop";
    license = licenses.mit;
    platforms = [ "x86_64-linux" ];
  };
}
