{
  inputs,
  ...
}:
{
  flake-file.inputs.noctalia-greeter = {
    url = "github:noctalia-dev/noctalia-greeter/cachix";
  };

  dotnix.noctalia-greeter = { user, ... }: {
    nixos = {
      imports = [
        inputs.noctalia-greeter.nixosModules.default
      ];
      nix.settings = {
        extra-substituters = [ "https://noctalia.cachix.org" ];
        extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
      };
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
}
