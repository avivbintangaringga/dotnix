{
  flake.modules.nixosModules.base = {
    sudo = {
      enable = true;
    };
  };
}
