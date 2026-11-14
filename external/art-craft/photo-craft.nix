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
}:

rustPlatform.buildRustPackage rec {
  pname = "photocraft";
  version = "0.21.0";

  src = fetchFromGitHub {
    owner = "storytold";
    repo = "photocraft";
    rev = "v${version}";
    hash = "sha256-TjW9nhq234RDe1fbb7oElMZwKwmDY+0UBNZvqUjdgJI=";
  };

  cargoHash = "sha256-u6hM6QTbRwbiuc24hGiQRv2Wsh70Wg07yZM1IQGVyUs=";

  #cargoLock = {
  #  lockFile = "${src}/Cargo.lock";
  #  allowBuiltinFetchGit = true;
  #};

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
  ];

  doCheck = false;

  postInstall = ''
    rm -f $out/bin/xtask
    install -Dm644 assets/app-icon/photocraft.svg \
          $out/share/icons/hicolor/scalable/apps/photocraft.svg
  '';

  postPatch = ''
    find . -name Cargo.toml -exec sed -i '/default-features = false/d' {} \;
  '';

  postFixup = ''
    for bin in photocraft photocraft-cli; do
      if [ -x "$out/bin/$bin" ]; then
        wrapProgram "$out/bin/$bin" \
          --prefix LD_LIBRARY_PATH : "${
            lib.makeLibraryPath [
              wayland
              libxkbcommon
              vulkan-loader
              stdenv.cc.cc.lib
            ]
          }"
      fi
    done
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "photocraft";
      desktopName = "Photo Craft [Fixed]";
      genericName = "Photo Editor";
      comment = "Open-source photo editor written in Rust";
      exec = "photocraft %F";
      icon = "photocraft";
      categories = [
        "Graphics"
        "2DGraphics"
        "RasterGraphics"
      ];
      mimeTypes = [
        "image/png"
        "image/jpeg"
        "image/tiff"
        "image/webp"
        "image/x-psd"
      ];
      terminal = false;
    })
  ];

  meta = with lib; {
    description = "An open-source, clean-room reimplementation of Adobe Photoshop in pure Rust";
    homepage = "https://github.com/storytold/photocraft";
    license = with licenses; [
      mit
      asl20
    ];
    platforms = platforms.linux;
    mainProgram = "photocraft";
  };
}
