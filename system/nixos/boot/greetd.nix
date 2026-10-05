{ pkgs, ... }:
{
  security.pam.services.greetd.enableGnomeKeyring = true; 

  services = {    
    gnome.gnome-keyring.enable = true;
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.hyprland}/bin/start-hyprland";
          user = "user";
        };
      };
    };
  };
}
