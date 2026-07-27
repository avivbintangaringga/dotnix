{
  dotnix.valent.nixos = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      valent
    ];

    networking.firewall = rec {
      allowedTCPPortRanges = [
        {
          from = 1714;
          to = 1764;
        }
      ];
      allowedUDPPortRanges = allowedTCPPortRanges;
    };
  };
}
