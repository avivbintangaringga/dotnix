{
  programs.kitty = {
    enable = true;
    shellIntegration = {
      enableZshIntegration = true;
    };
    settings = {
      background_opacity = 0.7;
      confirm_os_window_close = 0;
    };
    themeFile = "Catppuccin-Mocha";
  };
}
