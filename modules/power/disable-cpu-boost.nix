{
  dotnix.disable-cpu-boost = {
    nixos = { pkgs, ... }: {
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
  };
}
