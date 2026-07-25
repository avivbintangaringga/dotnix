{
  den.aspects.fonts = {
    nixos = { pkgs, ... }: {
      fonts.packages = (with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        lato
        open-sans
        roboto
        inter

        corefonts
        vista-fonts

        font-awesome
      ]) ++ (with pkgs.nerd-fonts; [
        jetbrains-mono
        fira-mono
        fira-code
      ]);
    };
  };
}
