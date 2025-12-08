{
  lib,
  config,
  ...
}:
{
  options = {
    setup.cli-apps.mise.enable = lib.mkEnableOption "Mise";
  };

  config = lib.mkIf config.setup.cli-apps.mise.enable {
    programs.mise = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
    };
  };
}
