{
  den.aspects.helix = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        helix
      ];
    };
  };
}
