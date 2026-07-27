{
  self,
  ...
}:
{
  dotnix.gamemode.nixos = { pkgs, ... }: {
    programs.gamemode = {
      enable = true;
      settings = {
        custom = {
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended' -i ${self + "/assets/icons/game.png"}";
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode started' -i ${
            self + "/assets/icons/game.png"
          }";
        };
        general.renice = 10;
      };
    };
  };
}
