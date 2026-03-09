{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: let
  system = pkgs.stdenv.hostPlatform.system;
  niri-float-sticky-pkgs = inputs.niri-float-sticky.packages.${system};
in {
  imports = [
    inputs.niri.nixosModules.niri
  ];

  options = {
    setup.desktop.niri.enable = lib.mkEnableOption "Niri";
  };

  config = lib.mkIf config.setup.desktop.niri.enable {
    environment.systemPackages = (with pkgs; [
      xwayland-satellite
      # gnome-keyring
    ])
    ++
    (with niri-float-sticky-pkgs; [
      niri-float-sticky
    ]);

    security.polkit.enable = true;

    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };
  };
}
