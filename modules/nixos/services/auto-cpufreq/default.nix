{ lib, config, inputs, ... }:
{
  imports = [
    inputs.auto-cpufreq.nixosModules.default
  ];
  
  options = {
    setup.services.auto-cpufreq = {
      enable = lib.mkEnableOption "Auto CPU Freq";
      turbo = lib.mkEnableOption "turbo";
    };
  };

  config = lib.mkIf config.setup.services.auto-cpufreq.enable {
    services.tlp.enable = lib.mkForce false;
    services.auto-cpufreq = 
    # programs.auto-cpufreq =
      let
        cfg = config.setup.services.auto-cpufreq;
        turbo = if cfg.turbo then "auto" else "never";
      in
      {
        enable = true;
        settings = {
          charger = {
            inherit turbo;
            gorvernor = "performance";
            scaling_max_freq = 3800000;
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
}
