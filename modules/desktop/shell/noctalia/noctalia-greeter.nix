{
  inputs,
  ...
}:
{
  flake-file.inputs.noctalia-greeter = {
    url = "github:noctalia-dev/noctalia-greeter";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  dotnix.noctalia-greeter = { user, ... }: {
    nixos = {
      imports = [
        inputs.noctalia-greeter.nixosModules.default
      ];
      programs = {
        noctalia-greeter = {
          enable = true;
          greeter-args = "--session Niri";
          settings = {
            appearance = {
              hide_logo = true;
            };
            cursor = {
              size = 24;
              theme = "Bibata-Modern-Classic";
            };
            output = {
              scale = 1.0;
            };
            session = {
              default = "Niri";
              last = "Niri";
            };
            user = {
              default = user.userName;
            };
          };
        };

        seahorse.enable = true;
      };
      services = {
        displayManager = {
          autoLogin = {
            enable = true;
            user = user.userName;
          };
        };
        greetd = {
          enable = true;
          settings = {
            initial_session = {
              command = "niri-session";
              user = user.userName;
            };
          };
        };
      };
      users.users.${user.userName} = {
        extraGroups = [ "greeter" ];
      };
    };
  };
}
