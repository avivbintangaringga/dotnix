{
  den.aspects.flakes = {
    nixos = {
      nix.settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
      };
    };
  };
}
