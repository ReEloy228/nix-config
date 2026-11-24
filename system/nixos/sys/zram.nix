{ ... }:
{
  zramSwap = {
    enable = false;
    memoryPercent = 30;

    swapDevices = [
      {
        device = "/var/lib/swapfile";
        size = 8 * 1024;
      }
    ];
  };
}
