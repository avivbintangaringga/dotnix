{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    setup.cli-apps.git.enable = lib.mkEnableOption "Git";
  };

  config = lib.mkIf config.setup.cli-apps.git.enable {
    environment.systemPackages = with pkgs; [
      gh
    ];

    programs.git = {
      enable = true;
    };
  };
}
