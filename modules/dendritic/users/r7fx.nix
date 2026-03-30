{
  flake.modules.nixosModules.r7fx = {
    users.users.r7fx = {
      extraGroups = [ "networkmanager" ];
    };
  };

  flake.modules.homeModules.r7fx = {

  };
}
