{
  nixpkgs = {
    config = {
      android_sdk = {
        accept_license = true;
      };
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
      permittedInsecurePackages = [
        "electron-39.8.10"
        "pnpm-10.34.0"
      ];
      # cudaSupport = true;
    };
  };
}
