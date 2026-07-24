{
  den.aspects.winbox = {
    nixos = { pkgs, ... }: {
      programs.winbox = {
        enable = true;
        openFirewall = true;
        package = pkgs.winbox4;
      };
    };
  };
}
