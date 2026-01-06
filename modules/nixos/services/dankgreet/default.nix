{
  lib,
  config,
  inputs,
  userdata,
  ...
}:
{
  imports = [
    inputs.dankmaterialshell.nixosModules.greeter
  ];
  
  options = {
    setup.services.dankgreet.enable = lib.mkEnableOption "Dank Material Shell Greeter";
  };

  config = lib.mkIf config.setup.services.dankgreet.enable {
    programs.dank-material-shell.greeter = {
      enable = true;
      compositor.name = "niri";
      configHome = userdata.userpath;
    };
  };
}
