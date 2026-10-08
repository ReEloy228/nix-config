{ ... }:
{
  programs.zen-browser.policies = {
    AutofillAddressEnabled = true;
    AutofillCreditCardEnabled = false;
    DisableFeedbackCommands = true;
    DisableFirefoxStudies = true;
    DisablePocket = true;
    DisableTelemetry = true;
    DisableAppUpdate = true;
    DisableFirefoxAccounts = true;
    OfferToSaveLogins = false;
    DNSOverHTTPS = {
      Enabled = true;
      Locked = true;
    };
    EnableTrackingProtection = {
      Value = true;
      Locked = true;
      Cryptomining = true;
      Fingerprinting = true;
    };
    DontCheckDefaultBrowser = true;
  };
}
