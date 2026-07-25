{
  lib,
  config,
  userdata,
  ...
}:
{
  options = {
    setup.cli-apps.git.enable = lib.mkEnableOption "Git";
  };

  config = lib.mkIf config.setup.cli-apps.git.enable {
  };
}
