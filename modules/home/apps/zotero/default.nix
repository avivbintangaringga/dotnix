{ pkgs, lib, config, ... }:
{
  options = {
    setup.apps.zotero.enable = lib.mkEnableOption "Zotero";
  };

  config = lib.mkIf config.setup.apps.zotero.enable {
    home.packages = with pkgs; [
      zotero
    ];
  };
}
