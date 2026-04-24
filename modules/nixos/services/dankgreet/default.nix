{
  lib,
  config,
  inputs,
  userdata,
  pkgs,
  ...
}:
{
  options = {
    setup.services.dankgreet.enable = lib.mkEnableOption "Dank Material Shell Greeter";
  };

  config = lib.mkIf config.setup.services.dankgreet.enable {
    services.displayManager = {
      autoLogin = {
        enable = true;
        user = userdata.username;
      };

      dms-greeter = {
        enable = true;
        compositor.name = "niri";
        configHome = userdata.userpath;
        configFiles = [
          "${userdata.userpath}/.config/DankMaterialShell/settings.json"
        ];
      };
    };
    
    programs.seahorse.enable = true;
    users.users.${userdata.username} = {
      extraGroups = [ "greeter" ];
    };
  };
}
