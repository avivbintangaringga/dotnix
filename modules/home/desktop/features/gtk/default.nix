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
      # gtk2.force = true;

      # iconTheme = {
      #   package = pkgs.adwaita-icon-theme;
      #   name = "Adwaita";
      # };

      # theme = {
      #   name = "Adwaita-dark";
      #   package = pkgs.gnome-themes-extra;
      # };
    };
  };
}
