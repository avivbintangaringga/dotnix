{
  lib,
  config,
  inputs,
  userdata,
  pkgs,
  ...
}:
{
  imports = [
    inputs.noctalia-greeter.nixosModules.default
  ];
  
  options = {
    setup.services.noctalia-greeter.enable = lib.mkEnableOption "Dank Material Shell Greeter";
  };

  config = lib.mkIf config.setup.services.noctalia-greeter.enable {
    services.displayManager = {
      autoLogin = {
        enable = true;
        user = userdata.username;
      };
    };
    
    programs = {
      noctalia-greeter = {
        enable = true;
        greeter-args = "--session niri-session";
      };
      
      seahorse.enable = true;
    };

    users.users.${userdata.username} = {
      extraGroups = [ "greeter" ];
    };
  };
}
