{ lib, config, options, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.setup.apps.firefox;
in
{
  options.setup.apps.firefox.enable = mkEnableOption "Enable Firefox";
  programs.firefox.enable = cfg.enable;
}
