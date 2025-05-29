{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
let
  apple-fonts-pkgs = inputs.apple-fonts.packages.${pkgs.system};
in
{
  options = {
    setup.fonts.apple.enable = lib.mkEnableOption "Apple Fonts";
  };

  config = lib.mkIf config.setup.fonts.apple.enable {
    fonts.packages = with apple-fonts-pkgs; [
      sf-pro
    ];
  };
}
