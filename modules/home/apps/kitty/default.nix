{ lib, config, options, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.setup.apps.kitty;
in
{
  options.setup.apps.kitty.enable = mkEnableOption "Enable Kitty";
  programs.kitty = {
    enable = cfg.enable;
    shellIntegration = {
      enableZshIntegration = true;
    };
    settings = {
      background_opacity = 0.8;
      confirm_os_window_close = 0;
      #window_padding_width = 4;
      enable_audio_bell = "no";
    };
    #themeFile = "Catppuccin-Mocha";
  };
}
