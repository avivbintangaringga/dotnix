{
  dotnix.cursor.homeManager = { pkgs, ... }: {
    home.pointerCursor = {
      enable = true;
      package = pkgs.bibata-cursors;
      gtk.enable = true;
      name = "Bibata-Modern-Classic";
      size = 24;
    };
  };
}
