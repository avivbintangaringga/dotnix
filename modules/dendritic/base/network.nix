{
  flake.modules.nixosModules.base = {
    networking = {
      useDHCP = true;
    };
  };
}
