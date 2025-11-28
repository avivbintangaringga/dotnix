{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    setup.apps.looking-glass-client.enable = lib.mkEnableOption "Looking Glass";
  };

  config = lib.mkIf config.setup.apps.looking-glass-client.enable {
    programs.looking-glass-client = {
      enable = true;
      settings = {
        
      };
      package = pkgs.looking-glass-client.override {
        pipewireSupport = false;
      };
    };
  };
}
