{ inputs, pkgs, ... }:
{
  imports = [ inputs.nixcord.homeModules.nixcord ];

  programs.nixcord = {
    enable = true;
    discord.vencord.enable = true;
    discord.package = pkgs.discord;
  };

  stylix.targets.nixcord.enable = true;
}
