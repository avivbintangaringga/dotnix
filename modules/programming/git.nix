{
  dotnix.git = {
    homeManager = { home, ... }: {
      programs = {
        gh = {
          enable = true;
          gitCredentialHelper.enable = true;
        };
        git = {
          enable = true;
          settings = {
            init.defaultBranch = "main";
            user = {
              email = home.git.email;
              name = home.git.userName;
            };
          };

          signing.format = "openpgp";
        };
      };
    };

    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        gh
        hub
      ];

      programs.git.enable = true;
    };
  };
}
