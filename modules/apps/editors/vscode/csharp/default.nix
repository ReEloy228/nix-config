{ pkgs, ... }:
{
  programs.vscode.profiles.default = {
    extensions = with pkgs.vscode-extensions; [
      ms-dotnettools.csharp
      ms-dotnettools.csdevkit
      ms-dotnettools.vscode-dotnet-runtime
    ];
    userSettings = {
      "dotnetAcquisitionExtension.existingDotnetPath" = [
        {
          "extensionId" = "ms-dotnettools.csharp";
          "path" = "${pkgs.dotnet-sdk}/bin/dotnet";
        }
        {
          "extensionId" = "ms-dotnettools.csdevkit";
          "path" = "${pkgs.dotnet-sdk}/bin/dotnet";
        }
      ];
      "dotnetAcquisitionExtension.sharedExistingDotnetPath" = "${pkgs.dotnet-sdk}/bin/dotnet";
    };
  };

  home = {
    packages = with pkgs; [ icu ];
    sessionVariables = {
      LD_LIBRARY_PATH = "${pkgs.icu}/lib";
    };
  };
}
