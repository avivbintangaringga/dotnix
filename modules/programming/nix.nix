{
  ...
}:
{
  flake-file.inputs.pedantix.url = "github:swarsel/pedantix";

  dotnix.nix.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [
      nixd
      nil
      nixfmt
      pedantix
    ];
  };
}
