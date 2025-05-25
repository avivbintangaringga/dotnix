{ lib, config, ... }:
{
  options = {
    setup.desktop.features.hyprpolkitagent.enable = lib.mkEnableOption "Hyprpolkitagent";
  };

  config = lib.mkIf config.setup.desktop.features.hyprpolkitagent.enable {
    services.hyprpolkitagent = {
      enable = true;
    };
  };
}
