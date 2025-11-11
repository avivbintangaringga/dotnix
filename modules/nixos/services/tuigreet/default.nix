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
          # session = "${pkgs.hyprland}/bin/Hyprland";
          session = "${pkgs.niri-unstable}/bin/niri";
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
              command = "${tuigreet} --asterisks --remember --remember-user-session --time --cmd ${session}";
              user = "greeter";
            };
          };
        };
    };
  };
}
