{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    setup.apps.ark.enable = lib.mkEnableOption "KDE Ark";
  };

  config = lib.mkIf config.setup.apps.ark.enable {
    home.packages = with pkgs; [
      kdePackages.ark
    ];
  };
}
