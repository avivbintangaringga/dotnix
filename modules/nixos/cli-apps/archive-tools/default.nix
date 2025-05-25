{ lib, config, pkgs, ... }:
{
  options = {
    setup.cli-apps.archive-tools.enable = lib.mkEnableOption "Archive Tools";
  };

  config = lib.mkIf config.setup.cli-apps.archive-tools.enable {
    environment.systemPackages = with pkgs; [
      zip
      unzip
      p7zip
      unrar
    ];
  };
}
