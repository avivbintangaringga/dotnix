{
  dotnix.nix-your-shell = {
    homeManager = {
      programs.nix-your-shell = {
        enable = true;
        enableZshIntegration = true;
      };
    };
  };
}
