{ config, lib, ... }:
{
  gtk = {
    iconTheme = {
      package = lib.mkForce config.stylix.icons.package;
      name = lib.mkForce (
        if config.stylix.polarity == "dark" then config.stylix.icons.dark else config.stylix.icons.light
      );
    };
    cursorTheme = {
      package = lib.mkForce config.stylix.cursor.package;
      name = lib.mkForce config.stylix.cursor.name;
      size = lib.mkForce config.stylix.cursor.size;
    };
  };
}
