{ pkgs, userdata, ... }:
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      edit = "vim /home/${userdata.username}/dotnix";
      update = "nh os switch /home/${userdata.username}/dotnix";
      hm-update = "nh home switch /home/${userdata.username}/dotnix";
    };
  };

  users.users.${userdata.username} = {
    shell = pkgs.zsh;
  };

  environment.shells = with pkgs; [
    zsh
  ];
}
