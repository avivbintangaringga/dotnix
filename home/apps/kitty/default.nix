{
  programs.kitty = {
    enable = true;
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
