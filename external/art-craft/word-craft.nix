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
  fontconfig,
}:

rustPlatform.buildRustPackage rec {
  pname = "wordcraft";
  version = "0.16.0";

  src = fetchFromGitHub {
    owner = "storytold";
    repo = "wordcraft";
    rev = "v${version}";
    hash = "sha256-7kZd99UuX2mwmYJkvVvvfaHAFpNkdPgHMPB0cBE5r+U=";
  };

  #cargoHash = "sha256-LsoTa1dUflP/Q2XKDUsEtk/kRdtgWyO87dXL2rPZEaI=";

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
    fontconfig
  ];

  doCheck = false;

  postInstall = ''
    rm -f $out/bin/xtask

    install -Dm644 assets/app-item/worgcraft.svg \
      $out/share/icons/hicolor/scalable/apps/wordcraft.svg
  '';

  postPatch = ''
    find . -name Cargo.toml -exec sed -i '/default-features = false/d' {} \;
  '';

  postFixup = ''
    for bin in wordcraft wordcraft-cli; do
      if [ -x "$out/bin/$bin" ]; then
        wrapProgram "$out/bin/$bin" \
          --prefix LD_LIBRARY_PATH : "${
            lib.makeLibraryPath [
              wayland
              libxkbcommon
              vulkan-loader
              stdenv.cc.cc.lib
              fontconfig
            ]
          }" \
          --prefix XDG_DATA_DIRS : "${fontconfig}/share"
      fi
    done
  '';

  desktopItems = [
    (makeDesktopItem {
      name = "wordcraft";
      desktopName = "Word Craft [Fixed]";
      genericName = "Word Processor";
      comment = "Open-source word processor written in Rust";
      exec = "wordcraft %F";
      icon = "wordcraft";
      categories = [
        "Office"
        "WordProcessor"
      ];
      mimeTypes = [
        "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
        "application/rtf"
        "application/pdf"
        "text/plain"
        "text/markdown"
      ];
      terminal = false;
    })
  ];

  meta = with lib; {
    description = "An open-source, clean-room reimplementation of Microsoft Word in pure Rust";
    homepage = "https://github.com/storytold/wordcraft";
    license = with licenses; [
      mit
      asl20
    ];
    platforms = platforms.linux;
    mainProgram = "wordcraft";
  };
}
