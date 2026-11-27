{
  dotnix.looking-glass.homeManager = { pkgs, lib, ... }: {
    programs.looking-glass-client = {
      enable = true;
      package = pkgs.looking-glass-client;
    };
    nixpkgs.overlays = [
      (_final: prev: {
        looking-glass-client = prev.looking-glass-client.overrideAttrs (oldAttrs: {
          src = prev.fetchFromGitHub {
            fetchSubmodules = true;
            hash = "sha256-ropEJC9+Gg85DS9XRuTb2IRGNNmUcA09Sy/cN6DTvZE=";
            owner = "gnif";
            repo = "LookingGlass";
            rev = "1b485305d9267207701d01adbe7907e90bfd6990";
          };
          version = "B8-rc1";
          patches = builtins.filter
            (p: !(lib.hasSuffix "nanosvg-unvendor.diff" (toString p)))
            (oldAttrs.patches or [ ]);
          
          cmakeFlags = (oldAttrs.cmakeFlags or [ ]) ++ [ "-DENABLE_BACKTRACE=no" ];
          buildInputs = (oldAttrs.buildInputs or [ ]) ++ (with prev; [
            fuse3
            usbredir
          ]);
        });
      })
    ];
  };
}
