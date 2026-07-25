{
  den.aspects.waydroid = {
    nixos = { pkgs, ... }: {
      virtualisation.waydroid.enable = true;
      networking.nftables.enable = true;
      environment.systemPackages = with pkgs;[
        waydroid-helper
        fakeroot
      ];
    };
  };
}
