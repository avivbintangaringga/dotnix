{
  dotnix.fonts = {
    homeManager.fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [ "Fira Mono" "Noto Sans Mono" ];
        sansSerif = [ "Liberation Sans" "Noto Sans" ];
        serif = [ "Liberation Serif" "Noto Serif" ];
      };
    };

    nixos = { pkgs, ... }: {
      fonts = {
        enableDefaultPackages = true;
        fontDir.enable = true;
        fontconfig = {
          enable = true;
          hinting = {
            enable = true;
            style = "medium";
          };
          subpixel = {
            rgba = "rgb";
            lcdfilter = "default";
          };
          defaultFonts = {
            sansSerif = [ "Liberation Sans" "Noto Sans" ];
            serif = [ "Liberation Serif" "Noto Serif" ];
          };
        };
        packages =
          (with pkgs; [
            noto-fonts
            noto-fonts-cjk-sans
            noto-fonts-color-emoji
            lato
            open-sans
            roboto
            inter
            liberation_ttf

            corefonts
            vista-fonts

            font-awesome
          ])
          ++ (with pkgs.nerd-fonts; [
            dejavu-sans-mono
            jetbrains-mono
            fira-mono
            fira-code
          ]);
      };
    };
  };
}
