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

    # security.pam.services = {
      # greetd.enableGnomeKeyring = true;
      # login.enableGnomeKeyring = true;
    # };

    services = {
      # gnome.gnome-keyring.enable = true;
      greetd =
        let
          # session = "${pkgs.hyprland}/bin/Hyprland";
          session = "${pkgs.niri-unstable}/bin/niri-session";
          tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
        in
        {
          enable = true;
          settings = {
            # initial_session = {
            #   command = "${session}";
            #   user = userdata.username;
            # };

            default_session = {
              command = "${tuigreet} --asterisks --remember --remember-user-session --time --cmd ${session}";
              user = "greeter";
            };
          };
        };
    };
  };
}
