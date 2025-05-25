{ lib, config, pkgs, ... }:
{
  options = {
    setup.fonts.basic.enable = lib.mkEnableOption "Basic Fonts";
  };

  config = lib.mkIf config.setup.fonts.basic.enable {
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      noto-fonts-color-emoji
      lato
      open-sans
      roboto
      inter
    ];
  };
}
