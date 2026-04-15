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
}
