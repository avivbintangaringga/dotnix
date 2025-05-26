{ lib, config, ... }:
{
  options = {
    setup.desktop.hyprland.enable = lib.mkEnableOption "Hyprland";
  };

  config = lib.mkIf config.setup.desktop.hyprland.enable {
    programs.hyprland.enable = true;
    services = {
      libinput.enable = true;
    };
  };
}
