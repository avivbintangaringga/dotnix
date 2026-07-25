{
  den,
  ...
}:
{
  den.aspects.dankmaterialshell = {
    includes = with den.aspects; [
      dankgreet
    ];

    homeManager = {
      home = {
        file = {
          ".config/niri/dms-overrides.kdl" = {
            source = ./niri/dms-overrides.kdl;
          };
        };
      };

      gtk = {
        gtk3 = {
          extraCss = ''
            @import url("dank-colors.css");
          '';
        };

        gtk4 = {
          extraCss = ''
            @import url("dank-colors.css");
          '';
        };
      };
    };
  };
}
