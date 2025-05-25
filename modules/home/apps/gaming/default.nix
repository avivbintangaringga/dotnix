{ lib, ... }:
{
  options = {
    setup.apps.gaming.all.enable = lib.mkEnableOption "Gaming Apps";
  };
}
