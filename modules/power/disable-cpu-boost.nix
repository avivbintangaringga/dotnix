{
  dotnix.disable-cpu-boost.nixos = { pkgs, ... }: {
    systemd.services.disable-cpu-boost = {
      after = [ "systemd-modules-load.service" ];
      description = "Disables CPU Turbo Boost";
      serviceConfig = {
        ExecStart = "${pkgs.bash}/bin/bash -c 'if [ -f /sys/devices/system/cpu/cpufreq/boost ]; then echo 0 > /sys/devices/system/cpu/cpufreq/boost; fi'";
        ExecStop = "${pkgs.bash}/bin/bash -c 'if [ -f /sys/devices/system/cpu/cpufreq/boost ]; then echo 1 > /sys/devices/system/cpu/cpufreq/boost; fi'";
        RemainAfterExit = true;
        Type = "oneshot";
      };
      wantedBy = [ "multi-user.target" ];
    };
  };
}
