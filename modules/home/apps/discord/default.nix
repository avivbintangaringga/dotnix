{ pkgs, lib, config, ... }:
{
  options = {
    setup.apps.discord.enable = lib.mkEnableOption "Discord";
  };

  config = lib.mkIf config.setup.apps.discord.enable {
    home.packages = with pkgs; [
      discord
    ];
  };
}
