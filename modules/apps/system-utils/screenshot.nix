{
  dotnix.screenshot = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        (writeShellApplication {
          name = "screenshot-full";
          runtimeInputs = [
            grim
            wl-clipboard
          ];
          text = ''
            grim -t png - | tee ~/Screenshots/Screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png | wl-copy -t image/png
          '';
        })
        (writeShellApplication {
          name = "screenshot-area";
          runtimeInputs = [
            grim
            slurp
            satty
          ];
          text = ''
            grim -g "$(slurp)" -t ppm - | satty --filename - --fullscreen --output-filename ~/Screenshots/Screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png
          '';
        })
      ];

    };
  };
}
