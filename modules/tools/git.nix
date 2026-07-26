{
  den.aspects.git = {
    homeManager = { home, ... }: {
      programs.git = {
        enable = true;
        settings = {
          user = {
            name = home.git.userName;
            email = home.git.email;
          };
          init.defaultBranch = "main";
        };

        signing.format = "openpgp";
      };

      programs.gh = {
        enable = true;
        gitCredentialHelper.enable = true;
      };
    };

    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        gh
        hub
      ];

      programs.git = {
        enable = true;
      };
    };
  };
}
