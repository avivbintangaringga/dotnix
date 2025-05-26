{ lib, config, ... }:
{
  options = {
    setup.cli-apps.nh.enable = lib.mkEnableOption "Nix Helper";
  };

  config = lib.mkIf config.setup.cli-apps.nh.enable {
    programs.nh = {
      enable = true;
    };
  };
}
