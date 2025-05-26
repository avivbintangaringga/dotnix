{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    setup.apps.winbox.enable = lib.mkEnableOption "Winbox";
  };

  config = lib.mkIf config.setup.apps.winbox.enable {
    programs.winbox = {
      enable = true;
      openFirewall = true;
      package = pkgs.winbox4;
    };
  };
}
