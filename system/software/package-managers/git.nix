{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    git
    git-credential-manager
  ];

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
  };
}
