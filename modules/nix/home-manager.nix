{
  flake-file.inputs.home-manager = {
    url = "github:nix-community/home-manager";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  dotnix.home-manager.nixos = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      home-manager
    ];
  };
}
