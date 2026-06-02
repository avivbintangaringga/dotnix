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
      ];
      # cudaSupport = true;
    };
  };
}
