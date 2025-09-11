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
      wuwatrack = ''url=$(grep -oE 'https://aki-gm-resources(-oversea)?.aki-game.(net|com)[^"]*' "$HOME/.local/share/Steam/steamapps/common/Wuthering Waves/Client/Saved/Logs/Client.log" | tail -n 1) && [ -n "$url" ] && echo "$url"'';
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
