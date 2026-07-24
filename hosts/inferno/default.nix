{
  mylib,
  lib,
  inputs,
  userdata,
  pkgs,
  ...
}:
let
  inherit (mylib) enabled disabled;
in
{
  imports = [
    ./../../modules/nixos/import.nix
    ./../../overlays/import.nix
  ];

  system.replaceDependencies.replacements = [
    # {
    #   oldDependency = pkgs.mesa;
    #   newDependency = pkgs.mesa-25-1-7;
    # }
  ];

  # services = {
  #    xserver = {
  #     enable = true;
  #     videoDrivers = [
  #       "amdgpu"
  #       "nvidia"
  #     ];
  #   };
  # };

  setup = {
    cli-apps = {
      adb = enabled;
      archive-tools = enabled;
      git = enabled;
      helix = enabled;
      home-manager = enabled;
      misc = enabled;
      monitoring = enabled;
      nh = enabled;
      nvim = enabled;
      nix-alien = disabled;
      zsh = enabled;
    };

    desktop = {
      hyprland = disabled;
      kde = disabled;
      mango = disabled;
      niri = enabled;
      features = {
        qt = enabled;
      };
    };

    fonts = {
      basic = enabled;
      ms = enabled;
      apple = disabled;
      nerd = enabled;
    };

    misc = {
      appimage = enabled;
      cpuid-fault-emulation = enabled;
      docker = enabled;
      docs = disabled;
      gaming = enabled;
      nix-ld = enabled;
      plymouth = disabled;
      waydroid = enabled;
      virt-manager = enabled;
      vmware = disabled;
    };

    services = {
      accounts-daemon = enabled;
      auto-cpufreq = {
        enable = false;
        turbo = true;
      };
      cloudflare-warp = enabled;
      dankgreet = disabled;
      disable-cpu-boost = enabled;
      flatpak = enabled;
      gvfs = enabled;
      logind = enabled;
      lsfg-vk = enabled;
      nfs = disabled;
      noctalia-greeter = enabled;
      ollama = disabled;
      pipewire = enabled;
      power-profiles-daemon = enabled;
      printing = enabled;
      samba = disabled;
      tuigreet = disabled;
      upower = enabled;
    };
  };

}
