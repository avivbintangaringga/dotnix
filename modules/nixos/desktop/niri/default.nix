{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.niri.nixosModules.niri
  ];

  options = {
    setup.desktop.niri.enable = lib.mkEnableOption "Niri";
  };

  config = lib.mkIf config.setup.desktop.niri.enable {
    environment.systemPackages = with pkgs; [
      xwayland-satellite
      # xdg-desktop-portal
      # xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
      gnome-keyring
    ];

    security.polkit.enable = true;

    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };
  };
}
