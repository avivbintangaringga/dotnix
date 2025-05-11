{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestions = {
      enable = true;
    };
    histSize = 10000;

    shellAliases = {
      edit = "sudo vim /etc/nixos/";
      update = "sudo nixos-rebuild switch";
    };

    ohMyZsh = {
      enable = true;
      theme = "fino-time";
      plugins = [
        "git"
      ];
    };
  }; 
}
