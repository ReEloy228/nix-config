{ pkgs, ... }:
{
  home.packages = with pkgs; [
    argc
    jq
    bash
    coreutils
  ];

  home.sessionPath = [ "$HOME/.config/aichat/functions" ];

  programs.aichat = {
    enable = true;
    settings = {
      model = "ollama:qwen3:8b";
      function_calling = true;
      use_tools = "fs_cat,fs_write,fs_ls";
      clients = [
        {
          type = "openai-compatible";
          name = "ollama";
          api_base = "http://localhost:11434/v1";
          models = [
            {
              name = "qwen3:8b";
              supports_function_calling = true;
            }
          ];
        }
      ];
    };
  };
}
