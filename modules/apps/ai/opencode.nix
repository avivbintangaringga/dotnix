{
  dotnix.opencode = {
    homeManager = { pkgs, ... }: {
      # home.packages = with pkgs; [
      #   opencode
      # ];
      multiverse.pins.opencode = "2.2.1";
    };
  };
}
