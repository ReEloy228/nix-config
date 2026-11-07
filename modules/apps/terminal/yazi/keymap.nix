{ ... }:
{
  programs.yazi.keymap = {
    mgr.prepend_keymap = [
      {
        on = [ "Enter" ];
        run = "plugin smart-enter";
        desc = "Войти в директорию или открыть файл";
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
