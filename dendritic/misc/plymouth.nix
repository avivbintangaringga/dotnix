{
  den.aspects.plymouth = { pkgs, ... }: {
    nixos = {
      boot = {
        plymouth = {
          enable = false;
          theme = "circle_hud";
          themePackages = with pkgs; [
            (adi1090x-plymouth-themes.override {
              selected_themes = [ "circle_hud" ];
            })
          ];
        };
        consoleLogLevel = 3;
        initrd.verbose = false;
        kernelParams = [
          "quiet"
          "splash"
          "boot.shell_on_fail"
          "udev.log_priority=3"
          "rd.systemd.show_status=auto"
        ];
      };
    };
  };
}
