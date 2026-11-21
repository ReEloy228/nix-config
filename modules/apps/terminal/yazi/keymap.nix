{ ... }:
{
  programs.yazi.keymap = {
    mgr.prepend_keymap = [
      {
        on = [ "Enter" ];
        run = "plugin smart-enter";
        desc = "Enter to directory or open file";
      }
      {
        on = [ "<C-y>" ];
        run = [
          "plugin wl-clipboard"
          "yank"
        ];
        desc = "Copy to system clipboard (Wayland)";
      }
    ];
  };
}
