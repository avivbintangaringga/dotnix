{ lib, config, ... }:
{
  options = {
    setup.apps.kitty.enable = lib.mkEnableOption "Kitty";
  };

  config = lib.mkIf config.setup.apps.kitty.enable {
    programs.kitty = {
      enable = true;
      shellIntegration = {
        enableZshIntegration = true;
      };
      settings = {
        background_opacity = 0.8;
        confirm_os_window_close = 0;
        enable_audio_bell = "no";
      };
    };
  };
}
