{ ... }:
{
  programs.brave = {
    enable = true;

    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; }
    ];

    commandLineArgs = [
      "--enable-features=UseOzonePlatform"
      "--ozone-platform=wayland"
      "--force-dark-mode"
      "--enable-features=WebUIDarkMode"
    ];
  };
}
