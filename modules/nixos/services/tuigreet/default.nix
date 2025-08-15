{
  lib,
  config,
  pkgs,
  userdata,
  ...
}:
{
  options = {
    setup.services.tuigreet.enable = lib.mkEnableOption "TUI Greet";
  };

  config = lib.mkIf config.setup.services.tuigreet.enable {
    environment.systemPackages = with pkgs; [
      tuigreet
    ];

    services = {
      greetd =
        let
          session = "${pkgs.hyprland}/bin/Hyprland";
          tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
        in
        {
          enable = true;
          settings = {
            initial_session = {
              command = "${session}";
              user = userdata.username;
            };
            default_session = {
              command = "${tuigreet} --greeting 'Welcome to NixOS!' --asterisks --remember --remember-user-session --time --cmd ${session}";
              user = "greeter";
            };
          };
        };
    };
  };
}
