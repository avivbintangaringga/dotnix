{ lib, config, ... }:
{
  options = {
    setup.cli-apps.zsh.enable = lib.mkEnableOption "ZSH";
  };

  config = lib.mkIf config.setup.cli-apps.zsh.enable {
    # home.packages = with pkgs; [
    #   zsh-powerlevel10k     
    # ];
    
    home.file = {
      ".p10k.zsh" = {
        source = ./p10k.zsh;
        force = true;
      };
    };

    programs.zsh = {
      enable = true;
      enableCompletion = true;
      syntaxHighlighting.enable = true;
      autosuggestion = {
        enable = true;
      };

      history.size = 10000;

      prezto = {
        enable = true;
        pmodules = [
          "environment"
          "terminal"
          "editor"
          "history"
          "directory"
          "spectrum"
          "utility"
          "completion"
          "prompt"
          # "git"
          "docker"
          "archive"
          "autosuggestions"
          "syntax-highlighting"
        ];
        prompt = {
          theme = "powerlevel10k";
        };
      };

      initContent = lib.mkBefore ''
        # cat ~/.cache/wal/sequences
        # source ~/.cache/wal/colors-tty.sh
        source ~/.p10k.zsh
      '';
    };
  };
}
