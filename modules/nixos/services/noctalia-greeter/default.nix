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

    services.greetd = {
      enable = true;
      settings = {
        initial_session = {
          command = "niri-session";
          user = userdata.username;
        };
      };
    };
    
    programs = {
      noctalia-greeter = {
        enable = true;
        greeter-args = "--session Niri";
        settings = {
          session = {
            default = "Niri";
            last = "Niri";
          };

          user = {
            default = userdata.username;
          };

          appearance = {
            hide_logo = true;
          };

          output = {
            scale = 1.0;
          };

          cursor = {
            theme = "Bibata-Modern-Classic";
            size = 24;
          };
        };
      };
      
      seahorse.enable = true;
    };

    users.users.${userdata.username} = {
      extraGroups = [ "greeter" ];
    };
  };
}
