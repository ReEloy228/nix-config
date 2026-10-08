{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ libX11 ];

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      zlib
      zstd
      stdenv.cc.cc
      curl
      openssl
      attr
      libssh
      bzip2
      libxml2
      acl
      libsodium
      util-linux
      xz
      systemd
      libXcomposite
      libXtst
      libXrandr
      libXext
      libX11
      libXfixes
      libXdamage
      libxcb
      libXxf86vm
      libGL
      wayland
      wayland-protocols
      libxkbcommon
      icu
      libunwind

      gtk3
      cairo
      pango
      gdk-pixbuf
      atk
      glib

      libXi
      libXcursor
      libXrender

      fontconfig
      freetype
      libgdiplus

      alsa-lib
      pulseaudio
      ffmpeg

      dbus
    ];
  };
}
