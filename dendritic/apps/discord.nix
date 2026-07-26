{
  den.aspects.discord = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        vesktop
      ];

      xdg.mimeApps.defaultApplications = {
        "x-scheme-handler/discord" = [ "vesktop.desktop" ];
      };
    };
  };
}
