{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    setup.desktop.features.gtk.enable = lib.mkEnableOption "GTK";
  };

  config = lib.mkIf config.setup.desktop.features.gtk.enable {
    gtk = {
      enable = true;

      gtk3 = {
        enable = true;
        extraCss = ''
            @import url("dank-colors.css");
          '';
        theme = {
          name = "adw-gtk3-dark";
          package = pkgs.adw-gtk3;
        };
      };

      gtk4 = {
        enable = true;
        extraCss = ''
            @import url("dank-colors.css");
          '';
        theme = {
          name = "adw-gtk3-dark";
          package = pkgs.adw-gtk3;
        };
      };
      
      iconTheme = {
        package = pkgs.papirus-icon-theme;
        name = "Papirus-Dark";
      };
    };
  };
}
