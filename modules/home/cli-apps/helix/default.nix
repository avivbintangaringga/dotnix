{
  lib,
  config,
  ...
}:
{
  options = {
    setup.cli-apps.helix.enable = lib.mkEnableOption "Helix";
  };

  config = lib.mkIf config.setup.cli-apps.helix.enable {
    programs.helix = {
      enable = true;
      settings = {
        theme = "base16_default";
      };
    };
  };
}
