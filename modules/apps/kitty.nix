{
  dotnix.kitty = {
    homeManager = { pkgs, ... }: {
      xdg = {
        terminal-exec.package = pkgs.kitty;
        mimeApps.defaultApplications = {
          "x-scheme-handler/terminal" = [ "kitty.desktop" ];
        };
      };

      programs.kitty = {
        enable = true;
        enableGitIntegration = true;
        shellIntegration = {
          enableZshIntegration = true;
          enableBashIntegration = true;
          enableFishIntegration = true;
        };
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
      };
    };
  };
}
