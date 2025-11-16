{ lib, config, pkgs, ... }:
{
  options = {
    setup.apps.nautilus.enable = lib.mkEnableOption "Nautilus";
  };

  config = lib.mkIf config.setup.apps.nautilus.enable {
    home.packages = with pkgs;[
      nautilus
    ];
    programs.nautilus-open-any-terminal = {
      enable = true;
      terminal = "kitty";
    };
  };
}
