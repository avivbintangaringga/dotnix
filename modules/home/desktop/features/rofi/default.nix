{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    setup.desktop.features.rofi.enable = lib.mkEnableOption "Rofi";
  };

  config = lib.mkIf config.setup.desktop.features.rofi.enable {
    programs.rofi = {
      enable = true;
      theme = "material";
      plugins = with pkgs; [
        rofi-emoji
      ];
    };
  };
}
