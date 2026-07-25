{
  den.aspects.auto-cpufreq = {
    nixos = {
      programs.auto-cpufreq =
        let
          # TODO: Find a way to make this configurable
          turbo = "never";
        in
        {
          enable = true;
          settings = {
            charger = {
              inherit turbo;
              gorvernor = "performance";
              scaling_max_freq = 3700000;
            };
            battery = {
              inherit turbo;
              governor = "powersave";
              scaling_max_freq = 1500000;
              platform_profile = "quiet";
              energy_per_bias = "balance_power";
            };
          };
        };
    };
  };
}
