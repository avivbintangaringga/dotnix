{ lib, config, pkgs, ... }:
{
  options = {
    setup.apps.kitty.enable = lib.mkEnableOption "Kitty";
  };

  config = lib.mkIf config.setup.apps.kitty.enable {
    home.packages = with pkgs;[
      nerd-fonts.dejavu-sans-mono
    ];
    programs.kitty = {
      enable = true;
      shellIntegration = {
        enableZshIntegration = true;
      };
      extraConfig = ''
        include dank-tabs.conf
        include dank-theme.conf
      '';
      settings = {
        background_opacity = 0.85;
        confirm_os_window_close = -1;
        enable_audio_bell = "no";
      };
    };
  };
}
