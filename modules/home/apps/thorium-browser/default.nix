{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
{
  options = {
    setup.apps.thorium-browser.enable = lib.mkEnableOption "Thorium Browser";
  };

  config = lib.mkIf config.setup.apps.thorium-browser.enable {
    home.packages = with inputs.thorium-browser.packages.${pkgs.stdenv.hostPlatform.system}; [
      thorium-avx2
    ];
  };
}
