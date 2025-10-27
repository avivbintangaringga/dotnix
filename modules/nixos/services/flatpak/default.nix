{ lib, config, ... }:
{
  options = {
    setup.services.flatpak.enable = lib.mkEnableOption "Flatpak";
  };

  config = lib.mkIf config.setup.services.flatpak.enable {
    services = {
      flatpak = {
        enable = true;
      };
    };
  };
}
