{
  inputs,
  den,
  ...
}:
{
  den.aspects.noctalia = {
    includes = with den.aspects; [
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
