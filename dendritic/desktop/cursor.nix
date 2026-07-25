{
  den.aspects.cursor = {
    homeManager = { pkgs, ... }: {
      home.pointerCursor = {
        enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 24;
        gtk = {
          enable = true;
        };
      };
    };
  };
}
