{
  inputs,
  den,
  ...
}:
{
  imports = [ inputs.den.flakeModule ];

  den.hosts.x86_64-linux.inferno = {
    users.r7fx = {};
  };

  den.aspects.inferno = {
    includes = [
      den.batteries.hostname
    ];

    nixos = {
      imports = [
        ./_hardware-configuration.nix
        inputs.hardware.nixosModules.asus-fa506ic
      ];
    };
  };
}
