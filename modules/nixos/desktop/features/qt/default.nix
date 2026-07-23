{
  pkgs,
  lib,
  config,
  inputs,
  userdata,
  ...
}:
{
  imports = [
    inputs.qtengine.nixosModules.default
  ];

  options = {
    setup.desktop.features.qt.enable = lib.mkEnableOption "QT";
  };

  config = lib.mkIf config.setup.desktop.features.qt.enable {

    environment.systemPackages = with pkgs.kdePackages; [
      # breeze
      # breeze.qt5
      # breeze-icons
    ];

    programs.qtengine = {
      enable = true;
      config = {
        theme = {
          colorScheme = "${userdata.userpath}/.local/share/color-schemes/noctalia.colors";
          iconTheme = "Papirus";
        };
      };
    };
  };
}
