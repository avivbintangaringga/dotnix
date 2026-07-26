{
  dotnix.bitwarden = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        bitwarden-desktop
      ];
    };
  };
}
