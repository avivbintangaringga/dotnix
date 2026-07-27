{
  flake-file.inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  den.default =
    let
      # TODO: USE BATTERIES
      nixpkgs = {
        config = {
          allowUnfree = true;
          allowUnfreePredicate = (_: true);
          android_sdk.accept_license = true;
          permittedInsecurePackages = [
            "electron-39.8.10"
            "electron-40.10.5"
            "pnpm-10.34.0"
          ];
          # cudaSupport = true;
        };
      };
    in
    {
      homeManager = {
        inherit nixpkgs;
      };
      nixos = {
        inherit nixpkgs;
      };
    };
}
