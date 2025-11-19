{
  inputs,
  pkgs,
  lib,
  config,
  ...
}: let
    mod = "SUPER";
in {
  imports = [
    inputs.mango.hmModules.mango
  ];

  options = {
    setup.desktop.mango.enable = lib.mkEnableOption "MangoWC";
  };

  config = lib.mkIf config.setup.desktop.mango.enable {
    setup.desktop.features = {
      cursor.enable = true;
      gtk.enable = true;
      wallpaper.enable = true;
    };

    wayland.windowManager.mango = {
      enable = true;
      settings = ''
          bind=${mod}, space, spawn, dms ipc call spotlight toggle
        '';
      autostart_sh = ''
          dms run
        '';
    };
  };
}
