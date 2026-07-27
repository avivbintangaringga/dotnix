{
  dotnix.gtk.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [
      papirus-folders
      nwg-look
    ];

    gtk = {
      enable = true;

      gtk3 = {
        enable = true;
        theme = {
          package = pkgs.adw-gtk3;
          name = "adw-gtk3-dark";
        };
      };

      gtk4 = {
        enable = true;
        theme = {
          package = pkgs.adw-gtk3;
          name = "adw-gtk3-dark";
        };
      };

      iconTheme.name = "Papirus";
    };
  };
}
