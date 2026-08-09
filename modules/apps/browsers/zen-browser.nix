{
  inputs,
  myLib,
  ...
}:
{
  flake-file.inputs.zen-browser = {
    url = "github:0xc000022070/zen-browser-flake/67202a6dc9ad712796fe31ef7797084d1fb8dbfe";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  dotnix.zen-browser.homeManager = {
    imports = [
      inputs.zen-browser.homeModules.beta
    ];
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
    xdg.mimeApps.defaultApplications = myLib.listToAttrsSameValue myLib.mimeTypes.browser [
      "zen-beta.desktop"
    ];
  };
}
