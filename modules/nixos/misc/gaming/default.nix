{ lib, config, pkgs, ... }:
{
  options = {
    setup.misc.gaming.enable = lib.mkEnableOption "Gaming tools";
  };

  config = lib.mkIf config.setup.misc.gaming.enable {
    environment.systemPackages = with pkgs; [
      libnotify
    ];

    programs.gamemode = {
      enable = true;
      settings = {
        general = {
          renice = 10;
        };

        custom = {
          start = "${pkgs.libnotify}/bin/notify-send 'GameMode started'";
          end = "${pkgs.libnotify}/bin/notify-send 'GameMode ended'";
        };
      };
    };

    programs.gamescope = {
      enable = true;
    };
  };
}
