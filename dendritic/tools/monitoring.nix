{
  den.aspects.monitoring = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        btop
        htop
        btdu
        powertop
        speedtest-cli
      ];
    };
  };
}
