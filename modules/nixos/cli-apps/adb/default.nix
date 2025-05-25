{ lib, config, userdata, ... }:
{
  options = {
    setup.cli-apps.adb.enable = lib.mkEnableOption "ADB";
  };

  config = lib.mkIf config.setup.cli-apps.adb.enable {
    programs.adb.enable = true;

    users.users.${userdata.username} = {
      extraGroups = [ "adbuser" ];
    };
  };
}
