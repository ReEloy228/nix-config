{ inputs, pkgs, ... }:
let
  kopuzPkg = inputs.kopuz.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
  home.packages = [ kopuzPkg ];

  systemd.user.services.kopuz = {
    Unit = {
      Description = "Kopuz Music Player";
      Before = [ "exit.target" ];
    };

    Service = {
      ExecStart = "${kopuzPkg}/bin/kopuz";
      KillSignal = "SIGTERM";
      TimeoutStopSec = "10s";
      Restart = "no";
    };

    Install.WantedBy = [ "default.target" ];
  };
}
