{
  den,
  ...
}:
{
  den.aspects.zsh = {
    includes = with den.batteries; [
      (user-shell "zsh")
    ];

    homeManager = {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;
        autosuggestion = {
          enable = true;
        };
        autocd = true;
        history.size = 100000;
      };
    };

    nixos = { user, ... }: {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        enableBashCompletion = true;
        histSize = 100000;
        autosuggestions = {
          enable = true;
        };
        syntaxHighlighting = {
          enable = true;
        };

        shellAliases = {
          edit = "hx /home/${user.userName}/dotnix";
          update = "nh os switch /home/${user.userName}/dotnix --no-nom --ask --show-trace";
          hm-update = "nh home switch /home/${user.userName}/dotnix --no-nom -b hm-bak --ask --show-trace";
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
          win11 = "vm-start win11";
          win10 = "vm-start win10";
          wuwatrack = ''url=$(grep -oE 'https://aki-gm-resources(-oversea)?.aki-game.(net|com)[^"]*' "$HOME/.local/share/Steam/steamapps/common/Wuthering Waves/Client/Saved/Logs/Client.log" | tail -n 1) && [ -n "$url" ] && echo "$url"'';

          # Git
          ga = "git add";
          gc = "git commit -m";
          gca = "git commit -am";
          gp = "git push";
          grl = "git reflog";
          gs = "git status";
          gd = "git diff";
          gco = "git checkout";
          gb = "git branch";
        };
      };

      programs.starship = {
        enable = true;
        presets = [
          "tokyo-night"
        ];
      };
    };
  };
}
