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
  ];

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

    misc = {
      gaming = enabled;
      nix-ld = enabled;
      plymouth = disabled;
      waydroid = enabled;
      virt-manager = enabled;
    };
  };

}
