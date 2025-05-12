{ userdata, ... }:
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
      vim = "nvim";
      edit = "vim /home/${userdata.username}/dotnix";
      update-nx = "sudo nixos-rebuild switch --flake";
      update-hm = "home-manager switch --flake";
    };

    oh-my-zsh = {
      enable = true;
      theme = "fino-time";
      plugins = [
        "git"
      ];
    };
  }; 
}
