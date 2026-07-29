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
            hash = "sha256-IDNxJrMMMvZk/PTKcPXXLrFRrLujwE/apfwHfLPjh1k=";
            owner = "gnif";
            repo = "LookingGlass";
            rev = "5196c5503ae87cc4f0decd17aa556973fc4a7308";
          };
          version = "5196c550";
        });
      })
    ];
  };
}
