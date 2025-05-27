{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    setup.cli-apps.python.enable = lib.mkEnableOption "Python";
  };

  config = lib.mkIf config.setup.cli-apps.python.enable {
    home.packages = with pkgs; [
      python3Full
    ];
  };
}
