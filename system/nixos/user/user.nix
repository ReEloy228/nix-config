{ lib, ... }:
{
  users.users.user = {
    isNormalUser = lib.mkForce true;
    description = lib.mkForce "User";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
    ];
    group = lib.mkForce "user";
  };
  users.groups.user = { };
}
