{
  inputs,
  ...
}:
{
  flake-file.inputs.pedantix.url = "github:swarsel/pedantix";

  dotnix.nix.homeManager = { pkgs, ... }: {
    imports = [
      inputs.pedantix.homeManagerModules.default
    ];

    home.packages = with pkgs; [
      nixd
      nil
      nixfmt
    ];
  };
}
