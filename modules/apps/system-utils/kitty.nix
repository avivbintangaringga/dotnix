{
  dotnix.kitty.homeManager = { pkgs, ... }: {
    programs.kitty = {
      enable = true;
      enableGitIntegration = true;
      # extraConfig = ''
      #   include dank-tabs.conf
      #   include dank-theme.conf
      # '';
      extraConfig = ''
        include themes/noctalia.conf
      '';
      settings = {
        background_opacity = 0.85;
        confirm_os_window_close = -1;
        enable_audio_bell = "no";
      };
      shellIntegration = {
        enableBashIntegration = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
      };
    };
    xdg = {
      mimeApps.defaultApplications."x-scheme-handler/terminal" = [ "kitty.desktop" ];
      terminal-exec.package = pkgs.kitty;
    };
  };
}
