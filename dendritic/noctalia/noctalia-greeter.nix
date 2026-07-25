{
  inputs,
  ...
}:
{
  den.aspects.noctalia-greeter = {
    nixos = { user, ... }: {
      imports = [
        inputs.noctalia-greeter.nixosModules.default
      ];

      services.displayManager = {
        autoLogin = {
          enable = true;
          user = user.userName;
        };
      };

      services.greetd = {
        enable = true;
        settings = {
          initial_session = {
            command = "niri-session";
            user = user.userName;
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
              default = user.userName;
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

      users.users.${user.userName} = {
        extraGroups = [ "greeter" ];
      };
    };
  };
}
