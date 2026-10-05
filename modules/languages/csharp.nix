{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [ dotnet-sdk_10 ];

  home.sessionVariables = {
    DOTNET_ROOT = lib.mkForce "${pkgs.dotnet-sdk_10}/share/dotnet";
    DOTNET_CLI_TELEMETRY_OPTOUT = "1";
    DOTNET_NOLOGO = "true";
  };
}
