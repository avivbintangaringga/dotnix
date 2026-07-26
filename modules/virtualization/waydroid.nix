{
  dotnix.waydroid = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        waydroid-helper
        fakeroot
      ];
      networking.nftables.enable = true;
      virtualisation.waydroid.enable = true;
    };
  };
}
