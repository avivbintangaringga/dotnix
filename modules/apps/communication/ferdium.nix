{
  dotnix.ferdium = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        ferdium
      ];

      xdg = {
        autostart = {
          enable = true;
          entries = [
            "${pkgs.ferdium}/share/applications/ferdium.desktop"
          ];
        };
      };
    };
  };
}
