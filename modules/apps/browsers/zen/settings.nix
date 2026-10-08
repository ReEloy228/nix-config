{ ... }:
{
  programs.zen-browser.profiles.default.settings = {
    "extensions.autoDisableScopes" = 0;
    "browser.tabs.allow_transparent_browser" = true;
    "zen.widget.linux.transparency" = true;
    "widget.transparent-windows" = true;
    "browser.newtabpage.activity-stream.feeds.system.topsites" = false;
    "browser.newtabpage.activity-stream.feeds.system.topstories" = false;
    "privacy.resistFingerprinting" = true;
    "permissions.default.shortcuts" = 0;
  };
}
