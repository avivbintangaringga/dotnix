{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    setup.cli-apps.helix.enable = lib.mkEnableOption "Helix";
  };

  config = lib.mkIf config.setup.cli-apps.helix.enable {
    environment.systemPackages = with pkgs; [
      # evil-helix
      helix
    ];
  };
}
