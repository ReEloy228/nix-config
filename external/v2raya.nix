{
  lib,
  stdenv,
  buildGo127Module,
  fetchFromGitHub,
  fetchYarnDeps,
  symlinkJoin,

  yarnConfigHook,
  yarnBuildHook,
  nodejs,

  makeWrapper,
  v2ray,
  v2ray-geoip,
  v2ray-domain-list-community,
  nix-update-script,
}:
let
  pname = "v2raya";
  version = "2.5.13";

  src = fetchFromGitHub {
    owner = "v2rayA";
    repo = "v2rayA";
    tag = "v${version}";
    hash = "sha256-LNBcGznrs2CcA5L6ENzw2kvtBi/+G1kGseK4dElh/WA=";
    postFetch = "sed -i -e 's/npmmirror/yarnpkg/g' $out/gui/yarn.lock";
  };

  web = stdenv.mkDerivation {
    inherit pname version src;

    sourceRoot = "${src.name}/gui";

    offlineCache = fetchYarnDeps {
      yarnLock = "${src}/gui/yarn.lock";
      hash = "sha256-6Yjlkfb43JbxtOeiOBdBLYsTCyHwlUHlcvLDnlWJx/k=";
    };

    env.OUTPUT_DIR = placeholder "out";

    nativeBuildInputs = [
      yarnConfigHook
      yarnBuildHook
      nodejs
    ];
  };

  assetsDir = symlinkJoin {
    name = "assets";
    paths = [
      v2ray-geoip
      v2ray-domain-list-community
    ];
  };

  core = buildGo127Module {
    pname = "v2raya_core";
    inherit version src;

    sourceRoot = "${src.name}/core";

    vendorHash = "sha256-0jMl0unNB5Atau+yKO7n4bR/Y1qzOKSG16S0Cu4lDz8=";

    ldflags = [
      "-s"
      "-w"
      "-X main.Version=${version}"
    ];

    subPackages = [ "main" ];

    postInstall = ''
      mv $out/bin/main $out/bin/v2raya_core
    '';
  };

in
buildGo127Module {
  inherit pname version src;

  sourceRoot = "${src.name}/service";

  vendorHash = "sha256-PE36aAmvazZVsFCmkYfEQe05/pWiE4CiEgtVnVBqqEs=";

  ldflags = [
    "-s"
    "-w"
    "-X github.com/v2rayA/v2rayA/conf.Version=${version}"
  ];

  subPackages = [ "." ];

  nativeBuildInputs = [ makeWrapper ];

  preBuild = ''
    cp -a ${web} server/router/web
  '';

  postInstall = ''
        install -Dm 444 ../install/universal/v2raya.desktop -t $out/share/applications
        install -Dm 444 ../install/universal/v2raya.png -t $out/share/icons/hicolor/512x512/apps
        substituteInPlace $out/share/applications/v2raya.desktop \
          --replace-fail 'Icon=/usr/share/icons/hicolor/512x512/apps/v2raya.png' 'Icon=v2raya'

    install -Dm 755 ${core}/bin/v2raya_core $out/bin/v2raya_core

        wrapProgram $out/bin/v2rayA \
          --prefix PATH ":" "${lib.makeBinPath [ v2ray ]}" \
          --prefix XDG_DATA_DIRS ":" ${assetsDir}/share \
          --set V2RAY_LOCATION_ASSET "${assetsDir}/share/v2ray" \
          --set XRAY_LOCATION_ASSET "${assetsDir}/share/v2ray"
  '';

  passthru = {
    inherit web;
    updateScript = nix-update-script {
      extraArgs = [
        "--subpackage"
        "web"
      ];
    };
  };

  meta = {
    description = "Linux web GUI client of Project V which supports V2Ray, Xray, SS, SSR, Trojan and Pingtunnel";
    homepage = "https://github.com/v2rayA/v2rayA";
    mainProgram = "v2rayA";
    license = lib.licenses.agpl3Only;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ ChaosAttractor ];
  };
}
