{
  nixpkgs = {
    config = {
      android_sdk = {
        accept_license = true;
      };
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      # cudaSupport = true;
    };
  };

  nix = {
    settings = {
      substituters = [
        "https://nix-community.cachix.org"
      ];

      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
}
