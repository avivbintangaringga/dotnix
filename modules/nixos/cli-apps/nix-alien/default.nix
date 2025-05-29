{ lib, config, pkgs, inputs, ... }:
let
  alien-pkgs = inputs.nix-alien.packages.${pkgs.system};
in
{
  options = {
    setup.cli-apps.nix-alien.enable = lib.mkEnableOption "Nix Alien";
  };

  config = lib.mkIf config.setup.cli-apps.nix-alien.enable {
    environment.systemPackages = with alien-pkgs; [
      nix-alien
    ];

    programs.nix-ld = {
      enable = true;
    };
  };
}
