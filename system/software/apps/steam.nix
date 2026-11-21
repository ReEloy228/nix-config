{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    package = pkgs.steam.override {
      extraLibraries =
        pkgs: with pkgs; [
          mesa
          libgbm
          libdrm
        ];
      extraEnv = {
        GBM_BACKENDS_PATH = "/run/opengl-driver/lib/gbm:/run/opengl-driver-32/lib/gbm";
        SDL_VIDEODRIVER = "x11";
        GTK_USE_PORTAL = "0";
        STEAM_FORCE_DESKTOPUI_SCALING = "1";
      };
      extraArgs = "-no-cef-sandbox -cef-disable-gpu -cef-disable-gpu-compositing";
    };
    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];
  };

  environment.systemPackages = with pkgs; [
    lsb-release
    glibcLocales
  ];

  environment.sessionVariables = {
    AMD_VULKAN_ICD = "RADV";
  };
}
