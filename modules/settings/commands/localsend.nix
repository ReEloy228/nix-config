{ ... }:
{
  programs.fish.shellAliases = {
    localsend-open = "sudo nixos-firewall-tool open tcp 53317 && sudo nixos-firewall-tool open udp 53317";
    localsend-close = "sudo nixos-firewall-tool reset";
  };
}
