{ pkgs, ... }:
{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-vulkan;
    loadModels = [
      "thealxlabs/lumen"
      "nomic-embed-text"
    ];
  };
}
