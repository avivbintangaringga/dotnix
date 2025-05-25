{ lib, config, pkgs, ... }:
{
  options = {
    setup.cli-apps.home-manager.enable = lib.mkEnableOption "Home Manager";
  };

  config = lib.mkIf config.setup.cli-apps.home-manager.enable {
    environment.systemPackages = with pkgs; [
      home-manager
    ];
  };
}
