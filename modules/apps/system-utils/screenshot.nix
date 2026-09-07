{
  dotnix.screenshot.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [
      (writeShellApplication {
        name = "screenshot-full";
        runtimeInputs = [
          grim
          wl-clipboard
          libnotify
        ];
        text = ''
          FILENAME="Screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png"
          FILE="$HOME/Screenshots/$FILENAME"
          grim -t png - | tee "$FILE" | wl-copy -t image/png
          notify-send "Screenshot saved as $FILENAME"
        '';
      })
      (writeShellApplication {
        name = "screenshot-area";
        runtimeInputs = [
          grim
          wl-clipboard
          libnotify
          slurp
        ];
        text = ''
          FILENAME="Screenshot_$(date +'%Y-%m-%d_%H-%M-%S').png"
          FILE="$HOME/Screenshots/$FILENAME"
          grim -g "$(slurp)" -t png - | tee "$FILE" | wl-copy -t image/png
          notify-send "Screenshot saved as $FILENAME"
        '';
      })
    ];

  };
}
