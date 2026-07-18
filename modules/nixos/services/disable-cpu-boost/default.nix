{ lib, config, pkgs, ... }:
{
  options = {
    setup.services.disable-cpu-boost.enable = lib.mkEnableOption "Disable Turbo Boost";
  };

  config = lib.mkIf config.setup.services.disable-cpu-boost.enable {
    systemd.services = {
      disable-cpu-boost = {
        description = "Disables CPU Turbo Boost";
        after = [ "systemd-modules-load.service" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "oneshot";
          RemainAfterExit = true;
          ExecStart = "${pkgs.bash}/bin/bash -c 'if [ -f /sys/devices/system/cpu/cpufreq/boost ]; then echo 0 > /sys/devices/system/cpu/cpufreq/boost; fi'";
          ExecStop = "${pkgs.bash}/bin/bash -c 'if [ -f /sys/devices/system/cpu/cpufreq/boost ]; then echo 1 > /sys/devices/system/cpu/cpufreq/boost; fi'";
        };
      };
    };
  };
}
