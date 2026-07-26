{
  dotnix.nix = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs;[
        nixd
        nil
        nixfmt
      ];
    };
  };
}
