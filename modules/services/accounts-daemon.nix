{
  den.aspects.accounts-daemon = {
    nixos = {
      services = {
        accounts-daemon = {
          enable = true;
        };
      };
    };
  };
}
