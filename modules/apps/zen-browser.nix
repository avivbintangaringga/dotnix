{
  inputs,
  myLib,
  ...
}: {
  flake-file.inputs.zen-browser = {
    url = "github:0xc000022070/zen-browser-flake";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  den.aspects.zen-browser = {
    homeManager = {
      imports = [
        inputs.zen-browser.homeModules.beta
      ];

      xdg.mimeApps.defaultApplications =
        myLib.listToAttrsSameValue myLib.mimeTypes.browser [ "zen-beta.desktop" ];

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
    };
  };
}
