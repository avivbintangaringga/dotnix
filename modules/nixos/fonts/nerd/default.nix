{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    setup.fonts.nerd.enable = lib.mkEnableOption "Nerd Fonts";
  };

  config = lib.mkIf config.setup.fonts.nerd.enable {
    fonts.packages =
      with pkgs.nerd-fonts;
      [
        jetbrains-mono
        fira-mono
        fira-code
      ]
      ++ (with pkgs; [
        font-awesome
      ]);
  };
}
