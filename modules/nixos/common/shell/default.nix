{ pkgs, userdata, ... }:
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      edit = "hx /home/${userdata.username}/dotnix";
      update = "nh os switch /home/${userdata.username}/dotnix --no-nom";
      hm-update = "nh home switch /home/${userdata.username}/dotnix --no-nom -b hm-bak";
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
      win11 = "vm-start win11";
      win10 = "vm-start win10";
    };
  };

  programs.starship = {
    enable = true;
  };

  users.users.${userdata.username} = {
    shell = pkgs.zsh;
  };

  environment.shells = with pkgs; [
    zsh
  ];
}
