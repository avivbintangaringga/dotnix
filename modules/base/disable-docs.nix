{
  dotnix.disable-docs = {
    nixos = {
      documentation = {
        enable = false;
        nixos.enable = false;
        dev.enable = false;
        info.enable = false;
        man.enable = false;
      };
    };
  };
}
