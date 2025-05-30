{
  lib,
  config,
  ...
}:
{
  options = {
    setup.cli-apps.go.enable = lib.mkEnableOption "Go";
  };

  config = lib.mkIf config.setup.cli-apps.go.enable {
    programs.go.enable = true;
  };
}
