{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    setup.fonts.ms.enable = lib.mkEnableOption "Microsoft Fonts";
  };

  config = lib.mkIf config.setup.fonts.ms.enable {
    fonts.packages = with pkgs; [
      corefonts
      vistafonts
    ];

    # LibreOffice Workaround
    # system.userActivationScripts = {
    #   copy-fonts-local-share = {
    #     text = ''
    #       rm -rf ~/.local/share/fonts
    #       mkdir -p ~/.local/share/fonts
    #       cp ${pkgs.corefonts}/share/fonts/truetype/* ~/.local/share/fonts/
    #       cp ${pkgs.vistafonts}/share/fonts/truetype/* ~/.local/share/fonts/
    #       chmod 544 ~/.local/share/fonts
    #       chmod 444 ~/.local/share/fonts/*
    #     '';
    #   };
    # };
  };
}
