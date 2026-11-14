{ inputs, ... }:
{
  imports = [ inputs.zapret-discord-youtube.nixosModules.withTestTools ];
  services.zapret-discord-youtube = {
    enable = true;
    configName = "general(ALT13)";
    gameFilter = "all";
    listGeneral = [
      "tr.rbxcdn.com"
      "cache.nixos.org"
      "cpan.metacpan.org"
    ];
  };
}
