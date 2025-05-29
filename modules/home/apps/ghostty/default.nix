{ lib, config, ... }:
{
  options = {
    setup.apps.ghostty.enable = lib.mkEnableOption "Ghostty";
  };

  config = lib.mkIf config.setup.apps.ghostty.enable {
    programs.ghostty = {
      enable = true;
      enableZshIntegration = true;
      clearDefaultKeybinds = true;
      settings =  {
        background-opacity = 0.7;
        background-blur = 0;
      };
    };
  };
}
