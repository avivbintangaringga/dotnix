{
  lib,
  config,
  ...
}:
{
  options = {
    setup.misc.docs.enable = lib.mkEnableOption "Documentation";
  };

  config = lib.mkIf (!config.setup.misc.docs.enable) {
    documentation = {
      enable = false;
      info.enable = false;
      dev.enable = false;
      man.enable = false;
      nixos.enable = false;
    };
  };
}
