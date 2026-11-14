{
  lib,
  stdenv,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  autoPatchelfHook,
  makeWrapper,
  copyDesktopItems,
  makeDesktopItem,
  vulkan-loader,
  vulkan-headers,
  libxkbcommon,
  wayland,
  libX11,
  libxcursor,
  libxrandr,
  libxi,
  openssl,
  zlib,
  alsa-lib,
  libpulseaudio,
}:

rustPlatform.buildRustPackage rec {
  pname = "effectcraft";
  version = "0.22.0";

  src = fetchFromGitHub {
    owner = "storytold";
    repo = "effectcraft";
    rev = "v${version}";
    hash = "sha256-G2WD/9lADzCqHRVfqvF+k2cv+Q6WRGpLZsQSGLiTX/k=";
  };
  #cargoHash = "sha256-y2dt8DhUWQ+l2k8P3V7VZqdCbzY7C5jja5RVBq6oz54=";

  cargoLock = {
    lockFile = "${src}/Cargo.lock";
    allowBuiltinFetchGit = true;
  };

  nativeBuildInputs = [
    pkg-config
    autoPatchelfHook
    makeWrapper
    copyDesktopItems
  ];

  buildInputs = [
    stdenv.cc.cc.lib
    vulkan-loader
    vulkan-headers
    libxkbcommon
    wayland
    libX11
    libxcursor
    libxrandr
    libxi
    openssl
    zlib
    alsa-lib
    libpulseaudio
  ];

  doCheck = false;

  postInstall = ''
    rm -f $out/bin/xtask

    install -Dm644 assets/app-icon/effectcraft.svg \
      $out/share/icons/hicolor/scalable/apps/effectcraft.svg
  '';

  postPatch = ''
    find . -name Cargo.toml -exec sed -i '/default-features = false/d' {} \;
  '';

  postFixup = ''
    for bin in effectcraft effectcraft-cli; do
      if [ -x "$out/bin/$bin" ]; then
        wrapProgram "$out/bin/$bin" \
          --prefix LD_LIBRARY_PATH : "${
            lib.makeLibraryPath [
              wayland
              libxkbcommon
              vulkan-loader
              stdenv.cc.cc.lib
              alsa-lib
              libpulseaudio
            ]
          }"
      fi
    done
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "effectcraft";
      desktopName = "Effect Craft [Fixed]";
      genericName = "Motion Graphics & VFX Compositor";
      comment = "Open-source motion graphics and visual effects compositor in Rust";
      exec = "effectcraft %F";
      icon = "effectcraft";
      categories = [
        "Graphics"
        "2DGraphics"
        "Video"
        "AudioVideo"
      ];
      mimeTypes = [
        "application/x-ecproj"
        "video/mp4"
        "video/quicktime"
        "image/png"
        "image/jpeg"
      ];
      terminal = false;
    })
  ];

  meta = with lib; {
    description = "An open-source, clean-room reimplementation of Adobe After Effects in pure Rust";
    homepage = "https://github.com/storytold/effectcraft";
    license = with licenses; [
      mit
      asl20
    ];
    platforms = platforms.linux;
    mainProgram = "effectcraft";
  };
}
