{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    setup.cli-apps.monitoring.enable = lib.mkEnableOption "Monitoring Tools";
  };

  config = lib.mkIf config.setup.cli-apps.monitoring.enable {
    environment.systemPackages = with pkgs; [
      btop
      htop
      btdu
      powertop
      speedtest-cli
    ];
  };
}
