{
  lib,
  config,
  ...
}:
{
  options = {
    setup.cli-apps.bun.enable = lib.mkEnableOption "Bun";
  };

  config = lib.mkIf config.setup.cli-apps.bun.enable {
    programs.bun.enable = true;
  };
}
