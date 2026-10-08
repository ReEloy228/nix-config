{ ... }:
{
  programs.zen-browser.policies.ExtensionSettings = {
    "firefox@equicord.org" = {
      installation_mode = "normal_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/equicord-web/latest.xpi";
    };
    "{60493d8c-aec8-448e-a247-5d2cfa047d69}" = {
      installation_mode = "normal_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/ambient-light-for-youtube/latest.xpi";
    };
    "zen-internet@sameerasw.com" = {
      installation_mode = "normal_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/zen-internet/latest.xpi";
    };
    "uBlock0@raymondhill.net" = {
      installation_mode = "normal_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
    };
    "jid1-MnnxcxisBPnSXQ@jetpack" = {
      installation_mode = "normal_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
    };
    "clearurls@kevinrwhitley.com" = {
      installation_mode = "normal_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi";
    };
    "jid1-BoFifL9Vbdl2zQ@jetpack" = {
      installation_mode = "normal_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/decentraleyes/latest.xpi";
    };
    "sponsorblock@ajay.app" = {
      installation_mode = "normal_installed";
      install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
    };
  };
}
