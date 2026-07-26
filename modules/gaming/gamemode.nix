{
  flake-root,
  ...
}:
{
  den.aspects.gamemode = {
    nixos = { pkgs, ... }: {
      programs.gamemode = {
        enable = true;
        settings = {
          general = {
            renice = 10;
          };

          custom = {
            start = "${pkgs.libnotify}/bin/notify-send 'GameMode started' -i ${flake-root + "/assets/icons/game.png"}";
            end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended' -i ${flake-root + "/assets/icons/game.png"}";
          };
        };
      };
    };
  };
}
