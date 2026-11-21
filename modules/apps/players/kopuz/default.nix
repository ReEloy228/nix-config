{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
let
  cfg = config.programs.kopuz;
  tomlFormat = pkgs.formats.toml { };
  kopuzPkg = inputs.kopuz.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  imports = [
    ./settings.nix
    ./theme.nix
  ];

  options.programs.kopuz = {
    enable = lib.mkEnableOption "Kopuz music player";

    package = lib.mkOption {
      type = lib.types.package;
      default = kopuzPkg;
      description = "The Kopuz package to use.";
    };

    settings = lib.mkOption {
      type = tomlFormat.type;
      default = { };
      description = "Configuration written to $XDG_CONFIG_HOME/kopuz/settings.toml.";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [ cfg.package ];

    xdg.configFile."kopuz/settings.toml" = lib.mkIf (cfg.settings != { }) {
      source = tomlFormat.generate "kopuz-settings.toml" cfg.settings;
    };

    systemd.user.services.kopuz = {
      Unit = {
        Description = "Kopuz Music Player";
        Before = [ "exit.target" ];
      };
      Service = {
        ExecStart = "${cfg.package}/bin/kopuz";
        KillSignal = "SIGTERM";
        TimeoutStopSec = "10s";
        Restart = "no";
      };
    };
  };
}
