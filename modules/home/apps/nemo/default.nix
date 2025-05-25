{ pkgs, lib, config, ... }:
{
  options = {
    setup.apps.nemo.enable = lib.mkEnableOption "Nemo";
  };

  config = lib.mkIf config.setup.apps.nemo.enable {
    home.packages = with pkgs; [
      nemo-with-extensions
    ];
  };
}
