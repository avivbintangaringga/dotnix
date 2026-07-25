{
  den.aspects.gtk = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        papirus-folders
        gtk3-x11
      ];

      gtk = {
        enable = true;

        gtk3 = {
          enable = true;
          theme = {
            name = "adw-gtk3-dark";
            package = pkgs.adw-gtk3;
          };
        };

        gtk4 = {
          enable = true;
          theme = {
            name = "adw-gtk3-dark";
            package = pkgs.adw-gtk3;
          };
        };

        iconTheme = {
          name = "Papirus";
        };
      };
    };
  };
}
