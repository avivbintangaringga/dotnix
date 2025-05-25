{ lib, config, options, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.setup.apps.zen-browser;
in
{
  options.setup.apps.zen-browser.enable = mkEnableOption "Enable Zen Browser";
  programs.zen-browser = {
    enable = cfg.enable;
    policies = {
      AutofillAddressEnabled = true;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
    };
  };
}
