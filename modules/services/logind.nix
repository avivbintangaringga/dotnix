{
  dotnix.logind = {
    nixos = {
      services.logind = {
        settings = {
          Login = {
            HandlePowerKey = "suspend";
            HandleLidSwitch = "suspend";
          };
        };
      };
    };
  };
}
