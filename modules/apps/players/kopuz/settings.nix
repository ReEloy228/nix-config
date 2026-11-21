{ config, lib, ... }:
{
  config = lib.mkIf config.programs.kopuz.enable {
    programs.kopuz.settings = lib.mkOptionDefault {
      language = "en";
      music_directory = [ "/home/user/Music" ];
      volume = 1;

      auto_check_updates = false;
      auto_fetch_covers = false;
      back_behavior = "RewindThenPrev";
      channel_mode = "Stereo";
      cover_art_background = false;
      cover_art_blur = 40;
      cover_art_darkening = 60;
      cover_fetch_strategy = "MusicBrainzFirst";
      crossfade_seconds = 2;
      custom_background_path = "";
      custom_font_path = "";
      device_change_behavior = "Pause";
      discord_presence = true;
      discord_presence_source = true;
      enable_musixmatch_lyrics = false;
      fullscreen_use_player_bar = false;
      live_theme_path = "";
      lyrics_depth_blur = true;
      lyrics_depth_blur_strength = 100;
      lyrics_offset_auto = true;
      lyrics_offset_ms = 0;
      minimize_to_tray = true;
      offline_quality = "Kbps320";
      player_bar_position = "Bottom";
      prefer_local_lyrics = false;
      reduce_animations = false;
      sample_rate_mode = "System";
      settings_layout = "TopBar";
      show_row_images = true;
      show_source_toggle = true;
      spotify_prefer_active_device = true;
      titlebar_mode = "Off";
      tracing_enabled = false;
      ui_style = "Normal";
      volume_scroll_step = 0.04;
      ytdlp_output_dir = "/home/user/Downloads";

      equalizer = {
        bands = [
          0.0
          0.0
          0.0
          0.0
          0.0
          0.0
          0.0
          0.0
          0.0
          0.0
        ];
        enabled = false;
        preamp_db = 0.0;
        preset = "Flat";
      };

      radio_registries = [
        {
          enabled = true;
          is_default = true;
          url = "https://raw.githubusercontent.com/Kopuz-org/kopuz/refs/heads/master/radio-registry/index.json";
        }
      ];

      ytdlp_options = {
        audio_quality = 0;
        convert_thumbnail = "";
        cookies_from_browser = "";
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

      replay_gain = {
        fallback_gain_db = 0.0;
        mode = "Off";
        normalize_loudness = true;
        preamp_db = 0.0;
        prevent_clipping = true;
      };
    };
  };
}
