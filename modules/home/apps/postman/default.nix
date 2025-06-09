{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    setup.apps.postman.enable = lib.mkEnableOption "Postman";
  };

  config = lib.mkIf config.setup.apps.postman.enable {
    home.packages = with pkgs; [
      postman
    ];
  };
}
