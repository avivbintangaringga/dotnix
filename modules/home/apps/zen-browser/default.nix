{
  lib,
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.zen-browser.homeModules.beta
    inputs.zen-nebula.homeModules.default
  ];

  options = {
    setup.apps.zen-browser.enable = lib.mkEnableOption "Zen Browser";
  };

  config = lib.mkIf config.setup.apps.zen-browser.enable {
    programs.zen-browser = {
      enable = true;
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

    zen-nebula = {
      enable = false;
      profile = "yiqaayu6.Default Profile";
    };
  };
}
