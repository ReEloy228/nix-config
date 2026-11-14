{ config, lib, ... }:
{
  home.pointerCursor = {
    size = lib.mkForce config.stylix.cursor.size;
    name = lib.mkForce config.stylix.cursor.name;
    package = lib.mkForce config.stylix.cursor.package;
  };
}
