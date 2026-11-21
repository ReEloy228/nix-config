{ config, ... }:
{
  programs.kopuz = {
    enable = true;
    settings = {
      language = "en";
      music_directory = [ "/home/user/Music" ];
      volume = 0.6;

      ytdlp_options = {
        audio_quality = 0;
        convert_thumbnail = "";
        cookies_from_browser = "firefox:${config.home.homeDirectory}/.config/zen/default";
        embed_chapters = false;
        embed_info_json = false;
        embed_metadata = true;
        embed_subs = false;
        embed_thumbnail = true;
        js_runtimes = "";
        no_mtime = false;
        no_playlist = false;
        postprocess_thumbnail_square = false;
        rate_limit = "";
        split_chapters = false;
        sponsorblock = false;
        sponsorblock_mark = false;
        write_auto_subs = false;
        write_comments = false;
        write_description = false;
        write_info_json = false;
        write_subs = false;
        write_thumbnail = false;
        xattrs = false;
      };
    };
  };
}
