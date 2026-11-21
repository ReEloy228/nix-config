{ ... }:
{
  programs.fish.shellAliases = {
    nix-sync = "sudo python3 /etc/nixos/system/scripts/sync/sync.py /home/user/Projects/nixos-config --ignore-file /etc/nixos/system/scripts/sync/sync.ignore --dontsync-file /etc/nixos/system/scripts/sync/dontsync.ignore";

    nix-switch = "nix-sync && nix-switch-without-sync";
    nix-switch-warn-trace = "nix-sync && NIX_ABORT_ON_WARN=1 nixos-rebuild switch --cores=6 --max-jobs=5 --impure --show-trace";
    nix-switch-without-sync = "sudo nixos-rebuild switch --cores=6 --max-jobs=5 --sudo";

    nix-build = "nix-sync && nix-build-without-sync";
    nix-build-warn-trace = "nix-sync && NIX_ABORT_ON_WARN=1 sudo nixos-rebuild build --cores=6 --max-jobs=5 --impure --show-trace";
    nix-build-without-sync = "sudo nixos-rebuild build --cores=6 --max-jobs=5 --sudo";

    nix-boot = "nix-sync && sudo nixos-rebuild boot --flake /etc/nixos#nixos";
    nix-test = "nix-sync && sudo nixos-rebuild test --flake /etc/nixos#nixos";
    nix-repair = "sudo nix-store --verify --check-contents --repair";
    nix-clean = "sudo nix-collect-garbage -d && sudo nix store optimise";
    nix-gc = "sudo nix-collect-garbage -d";
    nix-opt = "sudo nix store optimise";
    nix-old = "sudo nix-env --delete-generations old && sudo nix-collect-garbage";
    nix-size = "du -sh /nix/store 2>/dev/null || echo 'Nix store not accessible'";
    nix-rollback = "sudo nixos-rebuild switch --rollback";
    nix-gen = "sudo nix-env --list-generations --profile /nix/var/nix/profiles/system";
  };
}
