{ config, ... }:
{
  programs.yt-dlp = {
    enable = true;
    settings = {
      embed-thumbnail = true;
      add-metadata = true;
      cookies-from-browser = "firefox:${config.home.homeDirectory}/.config/zen/default";
    };
  };
}
