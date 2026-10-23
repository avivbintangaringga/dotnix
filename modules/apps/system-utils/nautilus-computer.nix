{
  inputs,
  ...
}:
{
  dotnix.nautilus-computer = {
    nixos = { pkgs, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;

      nautilus-my-computer =
        inputs.nautilus-computer.packages.${system}.default.overrideAttrs (old: {
          postInstall = (old.postInstall or "") + ''
            substituteInPlace \
              $out/share/nautilus-python/extensions/nautilus-my-computer.py \
              --replace-fail \
              'sys.path.insert(0, os.path.dirname' \
              'sys.path.insert(0, "${pkgs.python3Packages.pycairo}/${pkgs.python3.sitePackages}"); sys.path.insert(0, os.path.dirname'
          '';
        });
    in {
      environment.systemPackages = [ nautilus-my-computer ];
      environment.sessionVariables.XDG_DATA_DIRS = [ "${nautilus-my-computer}/share" ];
    };
  };
  flake-file.inputs.nautilus-computer = {
    inputs.nixpkgs.follows = "nixpkgs";
    url = "github:yannmasoch/nautilus-my-computer?dir=packaging/nix";
  };
}
