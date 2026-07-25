{
  den,
  flake-root,
  ...
}:
{
  den.aspects.gaming = {
    includes = with den.aspects; [
      lact
    ];

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

      programs.gamescope = {
        enable = true;
      };
    };
  };
}
