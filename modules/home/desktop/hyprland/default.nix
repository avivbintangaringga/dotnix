{
  lib,
  config,
  pkgs,
  ...
}@args:
{
  options = {
    setup.desktop.hyprland.enable = lib.mkEnableOption "Hyprland WM";
  };

  config = lib.mkIf config.setup.desktop.hyprland.enable {
    home.packages = with pkgs; [
      grimblast
    ];

    setup = {
      desktop.features = {
        cursor.enable = lib.mkDefault true;
        gtk.enable = lib.mkDefault true;
        hyprpolkitagent.enable = lib.mkDefault true;
        rofi.enable = lib.mkDefault true;
        swayosd.enable = lib.mkDefault true;
        swaync.enable = lib.mkDefault true;
        wallpaper.enable = lib.mkDefault true;
        waybar.enable = lib.mkDefault true;
      };
    };

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;

      settings = lib.mkMerge [
        {
          monitor =  [
            "eDP-1,1920x1080@144,auto,1"
            "HDMI-A-1,1920x1080@60,auto,1"
          ];
          #source = "~/.cache/hellwal/hyprland-colors.conf";
          source = "~/.cache/wal/colors-hyprland.conf";
        }
        (import ./vars.nix args)
        (import ./env.nix)
        (import ./exec.nix)
        (import ./general.nix)
        (import ./animation.nix)
        (import ./layout.nix)
        (import ./decoration.nix)
        (import ./binds.nix)
        (import ./input.nix)
        (import ./misc.nix)
        (import ./rules.nix)
      ];
    };
  };
}
