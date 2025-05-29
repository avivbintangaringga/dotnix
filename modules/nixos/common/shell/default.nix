{ pkgs, userdata, ... }:
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      edit = "vim /home/${userdata.username}/dotnix";
      update = "nh os switch /home/${userdata.username}/dotnix --no-nom";
      hm-update = "nh home switch /home/${userdata.username}/dotnix --no-nom";
      upgrade = ''
        cd /home/${userdata.username}/dotnix &&
        git add . &&
        git commit -m "before upgrade" &&
        git push &&
        nix flake update &&
        update &&
        hm-update &&
        git commit -am "after upgrade" &&
        git push &&
        echo "DONE!"
      '';
    };
  };

  users.users.${userdata.username} = {
    shell = pkgs.zsh;
  };

  environment.shells = with pkgs; [
    zsh
  ];
}
