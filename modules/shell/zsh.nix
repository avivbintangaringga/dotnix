{
  den,
  ...
}:
{
  dotnix.zsh = {
    includes = with den.batteries; [
      (user-shell "zsh")
    ];

    homeManager = {
      programs.zsh = {
        enable = true;
        autocd = true;
        autosuggestion = {
          enable = true;
        };
        enableCompletion = true;
        history.size = 100000;
        syntaxHighlighting.enable = true;
      };
    };

    nixos = { user, ... }: {
      programs = {
        starship = {
          enable = true;
          presets = [
            "tokyo-night"
          ];
        };
        zsh = {
          enable = true;
          autosuggestions = {
            enable = true;
          };
          enableBashCompletion = true;
          enableCompletion = true;
          histSize = 100000;
          shellAliases = {
            edit = "hx /home/${user.userName}/dotnix";
            # Git
            ga = "git add";
            gb = "git branch";
            gc = "git commit -m";
            gca = "git commit -am";
            gco = "git checkout";
            gd = "git diff";
            gp = "git push";
            grl = "git reflog";
            gs = "git status";
            hm-update = "nh home switch /home/${user.userName}/dotnix --no-nom -b hm-bak --ask --show-trace";
            update = "nh os switch /home/${user.userName}/dotnix --no-nom --ask --show-trace";
            upgrade = ''
              cd /home/${user.userName}/dotnix &&
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
            win10 = "vm-start win10";
            win11 = "vm-start win11";
            wuwatrack = ''url=$(grep -oE 'https://aki-gm-resources(-oversea)?.aki-game.(net|com)[^"]*' "$HOME/.local/share/Steam/steamapps/common/Wuthering Waves/Client/Saved/Logs/Client.log" | tail -n 1) && [ -n "$url" ] && echo "$url"'';
          };
          syntaxHighlighting = {
            enable = true;
          };
        };
      };
    };
  };
}
