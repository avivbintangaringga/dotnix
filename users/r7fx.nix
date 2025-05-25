{ userdata, ... }:
{
  imports = [
    ./common.nix
    ./../modules/home/import.nix
  ];

  setup = {
    apps = {
      gaming = {
        all.enable = true;
      };
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
