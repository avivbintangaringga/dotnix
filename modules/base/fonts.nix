{
  dotnix.fonts = {
    homeManager = {
      fonts.fontconfig = {
        enable = true;
        defaultFonts = {
          monospace = [ "Fira Mono" ];
          emoji = [ "Noto Color Emoji" ];
        };
      };
    };

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
        dejavu-sans-mono
        jetbrains-mono
        fira-mono
        fira-code
      ]);
    };
  };
}
