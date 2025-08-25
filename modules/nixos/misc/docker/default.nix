{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    setup.misc.docker.enable = lib.mkEnableOption "Docker";
  };

  config = lib.mkIf config.setup.misc.docker.enable {
    virtualisation.docker = {
      enable = true;
      enableOnBoot = true;
      rootless = {
        enable = true;
      };
      # autoPrune = {
      #   enable = true;
      # };
    };
  };
}
