{
  inputs,
  ...
}:
{
  flake-file.inputs.auto-cpufreq = {
    url = "github:AdnanHodzic/auto-cpufreq";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  dotnix.auto-cpufreq.nixos = {
    imports = [
      inputs.auto-cpufreq.nixosModules.default
    ];

    programs.auto-cpufreq =
      let
        # TODO: Find a way to make this configurable
        turbo = "never";
      in
      {
        enable = true;
        settings = {
          battery = {
            inherit turbo;
            energy_per_bias = "balance_power";
            governor = "powersave";
            platform_profile = "quiet";
            scaling_max_freq = 1500000;
          };
          charger = {
            inherit turbo;
            gorvernor = "performance";
            scaling_max_freq = 3700000;
          };
        };
      };
  };
}
