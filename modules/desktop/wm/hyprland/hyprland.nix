{
  dotnix,
  ...
}:
{
  dotnix.hyprland = {
    includes = with dotnix; [
      dankmaterialshell
    ];

    homeManager =
      {
        home,
        lib,
        pkgs,
        ...
      }:
      {
        home = {
          packages = with pkgs; [
            grimblast
          ];

          pointerCursor.hyprcursor = {
            enable = true;
            size = 24;
          };
        };
        services.hyprpolkitagent.enable = true;
        wayland.windowManager.hyprland = {
          enable = true;
          settings = lib.mkMerge [
            {
              monitor = [
                "eDP-1,1920x1080@144,auto,1"
                "HDMI-A-1,1920x1080@60,auto,1"
              ];
              #source = "~/.cache/hellwal/hyprland-colors.conf";
              # source = "~/.cache/wal/colors-hyprland.conf";
            }
            (import ./_config/vars.nix { home = "/home/${home.userName}"; })
            (import ./_config/env.nix)
            (import ./_config/exec.nix)
            (import ./_config/general.nix)
            (import ./_config/animation.nix)
            (import ./_config/layout.nix)
            (import ./_config/decoration.nix)
            (import ./_config/binds.nix)
            (import ./_config/input.nix)
            (import ./_config/misc.nix)
            (import ./_config/rules.nix)
          ];
          xwayland.enable = true;
        };
        xdg.portal.extraPortals = with pkgs; [
          xdg-desktop-portal-gnome
        ];
      };

    nixos = {
      programs.hyprland.enable = true;
      services.libinput.enable = true;
    };
  };
}
