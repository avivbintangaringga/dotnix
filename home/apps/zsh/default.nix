{ userdata, lib, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion = {
      enable = true;
    };

    history.size = 10000;

    shellAliases = {
      edit = "vim /home/${userdata.username}/dotnix";
      update = "sudo nixos-rebuild switch --flake";
      hm-update = "home-manager switch --flake";
    };

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


    #oh-my-zsh = {
    #  enable = true;
    #  theme = "fino-time";
    #  plugins = [
    #    "git"
    #  ];
    #};

    #initContent = lib.mkBefore ''
    #  chmod +x ~/.cache/hellwal/terminal-colors.sh
    #  sh ~/.cache/hellwal/terminal-colors.sh
    #'';

    initContent = lib.mkBefore ''
      cat ~/.cache/wal/sequences
      source ~/.cache/wal/colors-tty.sh
    '';
  }; 
}
