{ lib, config, ... }:
{
  options = {
    setup.cli-apps.zsh.enable = lib.mkEnableOption "ZSH";
  };

  config = lib.mkIf config.setup.cli-apps.zsh.enable {
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
          "git"
          "docker"
          "archive"
          "autosuggestions"
          "syntax-highlighting"
        ];
      };

      initContent = lib.mkBefore ''
        cat ~/.cache/wal/sequences
        source ~/.cache/wal/colors-tty.sh
      '';
    };
  };
}
