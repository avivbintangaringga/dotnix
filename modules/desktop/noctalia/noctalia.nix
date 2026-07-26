{
  inputs,
  dotnix,
  ...
}:
{
  flake-file.inputs.noctalia = {
    url = "github:noctalia-dev/noctalia/cachix";
  };

  dotnix.noctalia = {
    includes = with dotnix; [
      noctalia-greeter
    ];

    homeManager = {
      imports = [
        inputs.noctalia.homeModules.default
      ];

      programs.noctalia = {
        enable = true;
      };

      gtk = {
        gtk3 = {
          extraCss = ''
              @import url("noctalia.css");
            '';
        };

        gtk4 = {
          extraCss = ''
              @import url("noctalia.css");
            '';
        };
      };
    };

    nixos = {
      nix.settings = {
        extra-substituters = [
          "https://noctalia.cachix.org"
        ];

        extra-trusted-public-keys = [
          "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
        ];
      };
    };
  };
}
