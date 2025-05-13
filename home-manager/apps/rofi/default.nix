{ pkgs, ... }:
{
  programs.rofi = {
    enable = true;
    theme = "material";
    plugins = with pkgs; [
      rofi-emoji
    ];
  };
}
