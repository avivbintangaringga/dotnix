{
  inputs,
  ...
}:
{
  dotnix.noctalia-greeter = { user, ... }: {
    nixos = {
      imports = [
        inputs.noctalia-greeter.nixosModules.default
      ];
      services = {
        displayManager = {
          autoLogin = {
            enable = true;
            user = user.userName;
          };
          noctalia-greeter = {
            enable = true;
            greeter-args = "--session start-umbriel";
            passwordless-sync-users = [
              "${user.userName}"
            ];
            settings = {
              appearance.hide_logo = true;
              cursor = {
                size = 24;
                theme = "Bibata-Modern-Classic";
              };
              output.scale = 1.0;
              session.default = "Umbriel";
              user.default = user.userName;
            };
          };
        };
        greetd = {
          enable = true;
          settings.initial_session = {
            command = "start-umbriel";
            user = user.userName;
          };
        };
      };
    };
  };
  flake-file.inputs.noctalia-greeter = {
    inputs.nixpkgs.follows = "nixpkgs";
    url = "github:noctalia-dev/noctalia-greeter";
  };
}
