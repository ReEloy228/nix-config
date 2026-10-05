{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ vkbasalt ];
}
