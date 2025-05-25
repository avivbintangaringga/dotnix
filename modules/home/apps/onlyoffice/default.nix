{ lib, config, options, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.setup.apps.onlyoffice;
in
{
  options.setup.apps.onlyoffice.enable = mkEnableOption "Enable OnlyOffice";
  programs.onlyoffice = {
    enable = cfg.enable;
  };
}
