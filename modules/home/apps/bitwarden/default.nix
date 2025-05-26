{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    setup.apps.bitwarden.enable = lib.mkEnableOption "Bitwarden";
  };

  config = lib.mkIf config.setup.apps.bitwarden.enable {
    home.packages = with pkgs; [
      bitwarden
    ];
  };
}
