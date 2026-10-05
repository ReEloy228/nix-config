{ ... }:
{
  programs.yazi.settings = {
    manager = {
      ratio = [
        1
        4
        3
      ];
      sort_by = "natural";
      sort_dir_first = true;
      show_hidden = true;
    };
    preview = {
      image_filter = "lanczos3";
      tab_size = 2;
    };
  };
}
