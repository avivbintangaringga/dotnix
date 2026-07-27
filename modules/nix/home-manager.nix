{
  dotnix.home-manager.nixos = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      home-manager
    ];
  };
}
