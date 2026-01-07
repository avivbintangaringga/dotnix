{
  lib,
  config,
  userdata,
  pkgs,
  ...
}:
{
  options = {
    setup.cli-apps.adb.enable = lib.mkEnableOption "ADB";
  };

  config = lib.mkIf config.setup.cli-apps.adb.enable {
    environment.systemPackages = with pkgs; [
      android-tools
    ];

    users.users.${userdata.username} = {
      extraGroups = [ "adbuser" ];
    };
  };
}
