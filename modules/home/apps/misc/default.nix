{ pkgs, lib, config, ... }:
{
  options = {
    setup.apps.misc.enable = lib.mkEnableOption "Miscellaneous Apps";
  };

  config = lib.mkIf config.setup.apps.misc.enable {
    home.packages = with pkgs; [
      font-manager
    ];
  };
}
