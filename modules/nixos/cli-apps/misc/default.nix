{ lib, config, pkgs, ... }:
{
  options = {
    setup.cli-apps.misc.enable = lib.mkEnableOption "Miscellaneous";
  };

  config = lib.mkIf config.setup.cli-apps.misc.enable {
    environment.systemPackages = with pkgs; [
      fastfetch
      wget
      curl
      killall
      tree
    ];
  };
}
