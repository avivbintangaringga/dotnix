{ userdata, lib, mylib, ... }:
let
  inherit (mylib) enabled disabled;
in
{
  imports = [
    ./common.nix
    ./../modules/home/import.nix
  ];

  setup = {
    apps = {
      bitwarden = enabled;
      discord = enabled;
      firefox = enabled;
      gaming = {
        all = enabled;
      };
      kitty = enabled;
      mediaplayer = enabled;
      misc = enabled;
      nemo = enabled;
      obs-studio = enabled;
      onlyoffice = enabled;
      spicetify = enabled;
      zen-browser = enabled;
      zotero = enabled;
    };

    cli-apps = {
      git = enabled;
      nvim = enabled;
      scrcpy = disabled;
      yazi = enabled;
      zsh = enabled;
    };

    desktop = {
      hyprland = enabled;
    };

    services = {
      blueman = enabled;
      cliphist = enabled;
      playerctld = enabled;
    };
  };

  home = {
    username = userdata.username;
    homeDirectory = userdata.userpath;
    stateVersion = "24.11";
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "Fira Mono" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

}
