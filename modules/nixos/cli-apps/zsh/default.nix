{ lib, config, userdata, ... }:
{
  options = {
    setup.cli-apps.zsh.enable = lib.mkEnableOption "ZSH";
  };

  config = lib.mkIf config.setup.cli-apps.zsh.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableBashCompletion = true;
      histSize = 100000;
      autosuggestions = {
        enable = true;
      };
      syntaxHighlighting = {
        enable = true;
      };
    };

    programs.starship = {
      enable = true;
      presets = [
        "tokyo-night"
      ];
    };
  };
}
