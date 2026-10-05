{ ... }:
{
  programs.yazi.keymap = {
    manager.prepend_keymap = [
      {
        on = [ "Enter" ];
        run = "plugin smart-enter";
        desc = "Войти в директорию или открыть файл";
      }
    ];
  };
}
