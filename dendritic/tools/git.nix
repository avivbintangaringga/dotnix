{
  den.aspects.git = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        gh
        hub
      ];

      programs.git = {
        enable = true;
      };
    };
  };
}
