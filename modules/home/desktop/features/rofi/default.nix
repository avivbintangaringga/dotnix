{ pkgs, config, lib, ... }:
let
  cfg = config.desktop.features.rofi;
in
{
  options.desktop.features.rofi = lib.mkEnableOption "Enable rofi";
  programs.rofi = {
    enable = true;
    theme = "material";
    plugins = with pkgs; [
      rofi-emoji
    ];
  };
}
