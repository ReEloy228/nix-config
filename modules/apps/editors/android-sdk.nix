{ pkgs, ... }:
{
  home = {
    packages = with pkgs; [
      jdk17
      android-studio
    ];
    sessionVariables = {
      ANDROID_HOME = "${pkgs.android-studio}/lib/android-sdk";
      JAVA_HOME = "${pkgs.jdk17}";
    };
  };
}
