{ ... }:
let
  disk = "/dev/sda5";

  runLimited = builtins.concatStringsSep " " [
    "sudo systemd-run --scope --collect"
    "-p MemoryHigh=9G"
    "-p MemoryMax=11G"
    "-p MemorySwapMax=0"
    "-p CPUWeight=20"
    "-p IOWeight=20"
    "-p IOReadBandwidthMax='${disk} 150M'"
    "-p IOWriteBandwidthMax='${disk} 150M'"
  ];

  buildFlags = "-K --cores=6 --max-jobs=5";
  rebuildCmd = "${runLimited} nixos-rebuild";
  syncCmd = "sudo python3 /etc/nixos/system/scripts/sync/sync.py /home/user/Projects/nixos-config --ignore-file /etc/nixos/system/scripts/sync/sync.ignore --dontsync-file /etc/nixos/system/scripts/sync/dontsync.ignore";
in
{
  programs.fish.shellAliases = {
    nix-sync = syncCmd;

    nix-switch = "nix-sync && nix-switch-without-sync";
    nix-switch-without-sync = "${rebuildCmd} switch ${buildFlags}";
    nix-switch-warn-trace = "nix-sync && NIX_ABORT_ON_WARN=1 ${rebuildCmd} switch ${buildFlags} --impure --show-trace";

    nix-build = "nix-sync && nix-build-without-sync";
    nix-build-without-sync = "${rebuildCmd} build ${buildFlags}";
    nix-build-warn-trace = "nix-sync && NIX_ABORT_ON_WARN=1 ${rebuildCmd} build ${buildFlags} --impure --show-trace";

    nix-boot = "nix-sync && ${rebuildCmd} boot --flake /etc/nixos#nixos";
    nix-test = "nix-sync && ${rebuildCmd} test --flake /etc/nixos#nixos";
    nix-rollback = "${rebuildCmd} switch --rollback";

    nix-repair = "${runLimited} nix-store --verify --check-contents --repair";
    nix-clean = "${runLimited} sh -c 'nix-collect-garbage -d && nix store optimise'";
    nix-gc = "${runLimited} nix-collect-garbage -d";
    nix-opt = "${runLimited} nix store optimise";
    nix-old = "${runLimited} sh -c 'nix-env --delete-generations old && nix-collect-garbage'";

    nix-size = "du -sh /nix/store 2>/dev/null || echo 'Nix store not accessible'";
    nix-gen = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
  };
}
