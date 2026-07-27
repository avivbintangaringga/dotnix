{
  dotnix.steam.nixos = { pkgs, ... }: {
    programs.steam = {
      enable = true;
      extraPackages = with pkgs; [
        gamescope
      ];
      protontricks.enable = true;
    };
  };
}
