{
  dotnix.droidloom.nixos = {
    imports = [
      ./_module.nix
    ];

    programs.droidloom = {
      enable = true;
      users = [
        "r7fx"
      ];
    };
  };
}
