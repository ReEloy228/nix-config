{ inputs, ... }:
{
  imports = [ inputs.zapret-discord-youtube.nixosModules.withTestTools ];

  services.zapret-discord-youtube = {
    enable = true;
    configName = "general(ALT13)";

    # 1. Отключаем GameFilter ("null" — строго строкой), чтобы zapret не ломал
    # игровые и служебные порты Steam (27015–27050)
    gameFilter = "null";

    listGeneral = [
      "tr.rbxcdn.com"
      "cache.nixos.org"
      "cpan.metacpan.org"
    ];

    # 2. Добавляем домены Steam и его CDN в исключения (поддомены учитываются автоматически)
    listExclude = [
      "steampowered.com"
      "steamcommunity.com"
      "steamstatic.com"
      "steamserver.net"
      "steamcontent.com"
      "steamconnecttest.com"
      "valvesoftware.com"
      "akamaihd.net"
    ];

    # 3. Исключаем подсети Akamai CDN, на которых у вас зависал Connectivity test
    ipsetExclude = [
      "23.0.0.0/8"
      "92.122.0.0/15"
      "2.16.0.0/13"
    ];
  };
}
