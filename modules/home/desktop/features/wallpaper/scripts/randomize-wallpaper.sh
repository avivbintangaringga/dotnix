#!/bin/sh

QUIET=false
WITH_WAYBAR=false

ARGS=$(getopt -l "quiet:with-waybar" -o "q:w" -- "$@")
eval set -- "$ARGS"

while [ $# -ge 1 ]
do
  case "$1" in
    --)
        shift
        break
        ;;
    -q|--quiet)
        QUIET=true
        shift
        ;;
    -w|--with-waybar)
        WITH_WAYBAR=true
        shift
        ;;
  esac
  shift
done

WALLPAPER_DIR="$HOME/.wallpapers/"
CURRENT_FILE="${WALLPAPER_DIR}/.current"
CURRENT_WALLPAPER=$(cat $CURRENT_FILE)

echo "Current wallpaper: $CURRENT_WALLPAPER"

WALLPAPER=$(find "$WALLPAPER_DIR" \( -type f -o -type l \) -regex ".*/.*\.\(jpg\|jpeg\|png\|gif\)" ! -name "$CURRENT_WALLPAPER" | shuf -n 1)

echo "Selected wallpaper: $WALLPAPER"
echo "$(basename $WALLPAPER)" > $CURRENT_FILE

# Regenerate colors
# hellwal -i "$WALLPAPER" --bright-offset 0.1 --neon-mode
wal -n -i "$WALLPAPER" --contrast 3

# Apply the selected wallpaper
swww img "$WALLPAPER" --transition-type grow --transition-fps 60 --transition-step 2 --transition-duration 1 --transition-pos top-right

# Reload swaync css
swaync-client -rs

# Restart swayosd
systemctl --user restart swayosd

if ! $QUIET
then
  notify-send -i "$WALLPAPER" "Wallpaper changed"
fi

if $WITH_WAYBAR
then
  systemctl --user restart waybar
fi
