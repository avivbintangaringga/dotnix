{
  den,
  dotnix,
  ...
}:
{
  dotnix.zsh = {
    includes = with den.batteries; [
      (user-shell "zsh")
    ];

    homeManager = { home, pkgs, ... }: {
      home.packages = with pkgs; [
        (
          if home.flakePath != null then
            (writeShellApplication {
              name = "upgrade";
              runtimeInputs = [
                coreutils
                nh
                git
              ];
              text = ''
                SUDO="sudo"
                NH_ASK="--ask"
                NH_SUDO="--bypass-root-check"
                NH_COMMIT="--commit-lock-file"
                TOKEN=$(sudo -u ${home.userName} gh auth token)

                while [ $# -gt 0 ]
                do
                    case "$1" in
                        --no-ask)
                          NH_ASK=""
                          shift
                          ;;
                        --no-commit)
                          NH_COMMIT=""
                          shift
                          ;;
                         --no-sudo)
                            SUDO=""
                            NH_SUDO=""
                            shift
                            ;;
                        --)
                          shift
                          break
                          ;;
                    esac
                done

                cd "${home.flakePath}"

                git config user.email ${home.git.email}
                git config user.email ${home.git.userName}

                $SUDO nh os switch . --no-nom --show-trace --update $NH_ASK $NH_SUDO $NH_COMMIT -- --option access-tokens "github.com=$TOKEN"
                nh home switch . --no-nom -b hm-bak --show-trace --update $NH_ASK $NH_COMMIT -- --option access-tokens "github.com=$TOKEN"
              '';
            })
          else
            null
        )
      ];

      programs.zsh = {
        enable = true;
        autocd = true;
        autosuggestion.enable = true;
        enableCompletion = true;
        history.size = 100000;
        shellAliases =
          { }
          // (
            if dotnix ? kitty then
              {
                ssh = "kitty +kitten ssh";
              }
            else
              { }
          )
          // (
            if home ? flakePath && home.flakePath != null then
              {
                edit = "hx ${home.flakePath}";
                hm-update = "nh home switch ${home.flakePath} --no-nom -b hm-bak --ask --show-trace";
                update = "nh os switch ${home.flakePath} --no-nom --ask --show-trace";
              }
            else
              { }
          )
          // (
            if dotnix ? gaming then
              {
                wuwatrack = ''url=$(grep -oE 'https://aki-gm-resources(-oversea)?.aki-game.(net|com)[^"]*' "$HOME/.local/share/Steam/steamapps/common/Wuthering Waves/Client/Saved/Logs/Client.log" | tail -n 1) && [ -n "$url" ] && echo "$url"'';
              }
            else
              { }
          )
          // (
            if dotnix ? kvm then
              {
                win10 = "vm-start win10";
                win11 = "vm-start tiny11";
              }
            else
              { }
          );
        syntaxHighlighting.enable = true;
      };
    };

    nixos = { ... }: {
      programs = {
        starship = {
          enable = true;
          presets = [
            "tokyo-night"
          ];
        };
        zsh = {
          enable = true;
          autosuggestions.enable = true;
          enableBashCompletion = true;
          enableCompletion = true;
          histSize = 100000;
          shellAliases =
            { }
            // (
              if dotnix ? git then
                {
                  ga = "git add";
                  gb = "git branch";
                  gc = "git commit -m";
                  gca = "git commit -am";
                  gco = "git checkout";
                  gd = "git diff";
                  gm = "git merge";
                  gp = "git push";
                  grl = "git reflog";
                  gs = "git status";
                }
              else
                { }
            );
          syntaxHighlighting.enable = true;
        };
      };
    };
  };
}
