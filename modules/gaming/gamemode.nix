{
  self,
  ...
}:
{
  dotnix.gamemode = {
    nixos = { pkgs, ... }: {
      programs.gamemode = {
        enable = true;
        settings = {
          general = {
            renice = 10;
          };

          custom = {
            start = "${pkgs.libnotify}/bin/notify-send 'GameMode started' -i ${self + "/assets/icons/game.png"}";
            end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended' -i ${self + "/assets/icons/game.png"}";
          };
        };
      };
    };
  };
}
