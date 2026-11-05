{
  dotnix.anydesk.homeManager = { pkgs, ... }: {
    # home.packages = with pkgs; [
    #   anydesk
    # ];
    multiverse.pins.anydesk = "8.0.4";
  };
}
