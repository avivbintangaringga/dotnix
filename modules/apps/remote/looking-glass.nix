{
  dotnix.looking-glass.homeManager = { pkgs, ... }: {
    programs.looking-glass-client = {
      enable = true;
      package = pkgs.looking-glass-client.override {
        # pipewireSupport = false;
      };
      settings = {

      };
    };
    nixpkgs.overlays = [
      (_final: prev: {
        looking-glass-client = prev.looking-glass-client.overrideAttrs (oldAttrs: {
          buildInputs =
            (oldAttrs.buildInputs or [ ])
            ++ (with pkgs; [
              libunwind
              elfutils
            ]);
          src = prev.fetchFromGitHub {
            fetchSubmodules = true;
            hash = "sha256-Z6S4QiOjn/bJYLSaXQ9N+tOGts1K2ouubVymZdZe324=";
            owner = "gnif";
            repo = "LookingGlass";
            rev = "3035fa628280d669d847c395bb3f47bdbee3f933";
          };
          version = "3035fa6";
        });
      })
    ];
  };
}
