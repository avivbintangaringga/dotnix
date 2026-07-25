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

    misc = {
      cpuid-fault-emulation = enabled;
      docs = disabled;
      gaming = enabled;
      nix-ld = enabled;
      plymouth = disabled;
      waydroid = enabled;
      virt-manager = enabled;
      vmware = disabled;
    };
  };

}
