{
  den.aspects.home-manager = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        home-manager
      ];
    };
  };
}
