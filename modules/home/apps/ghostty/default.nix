{ lib, config, userdata, ... }:
{
  options = {
    setup.apps.ghostty.enable = lib.mkEnableOption "Ghostty";
  };

  config = lib.mkIf config.setup.apps.ghostty.enable {
    programs.ghostty = {
      enable = true;
      enableZshIntegration = true;
      clearDefaultKeybinds = false;
      settings = {
        # config-file = "./config-dankcolors";
        background-opacity = 0.9;
        background-blur = 0;
        font-size = 11;
        font-family = "FiraCode Nerd Font";
        window-padding-x = 4;
        window-padding-y = 4;
      };
    };
  };
}
