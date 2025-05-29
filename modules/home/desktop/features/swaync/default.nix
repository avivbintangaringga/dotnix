{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    setup.desktop.features.swaync.enable = lib.mkEnableOption "SwayNC";
  };

  config = lib.mkIf config.setup.desktop.features.swaync.enable {
    home.packages = with pkgs; [
      libnotify
    ];

    services.swaync = {
      enable = true;
      style = ./style.css;
      settings = {
        positionX = "right";
        positionY = "top";
        layer = "overlay";
        cssPriority = "user";
        control-center-margin-top = 20;
        control-center-margin-bottom = 20;
        control-center-margin-right = 20;
        control-center-layer = "overlay";
        control-center-exclusive-zone = false;
        notification-2fa-action = true;
        timeout = 5;
        timeout-low = 5;
        timeout-critical = 0;
        notification-window-width = 500;
        keyboard-shortcuts = true;
        image-visibility = "when-available";
        transition-time = 100;
        hide-on-clear = false;
        hide-on-action = true;
        text-empty = "No notifications.";
        widgets = [
          "buttons-grid"
          "mpris"
          "backlight"
          "volume"
          "dnd"
          "title"
          "notifications"
        ];
        widget-config = {
          title = {
            text = "  Notifications";
            clear-all-button = true;
            button-text = " Clear";
          };
          mpris = {
            image-size = 50;
            image-radius = 8;
          };
          dnd = {
            text = "  Do not disturb";
          };
          buttons-grid = {
            actions = [
              {
                label = "";
                type = "normal";
                command = "ghostty -e nmtui-connect";
              }
              {
                label = "󰂯";
                type = "normal";
                command = "blueman-manager";
              }
              {
                label = "󰝟";
                type = "toggle";
                command = "sh -c '[[ $SWAYNC_TOGGLE_STATE = true ]] && wpctl set-mute @DEFAULT_AUDIO_SINK@ 1 || wpctl set-mute @DEFAULT_AUDIO_SINK@ 0'";
                update-command = "sh -c '[[ $(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -i mute) ]] && echo true || echo false'";
              }
              {
                label = "";
                type = "toggle";
                command = "sh -c '[[ $SWAYNC_TOGGLE_STATE = true ]] && wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 1 || wpctl set-mute @DEFAULT_AUDIO_SOURCE@ 0'";
                update-command = "sh -c '[[ $(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -i mute) ]] && echo true || echo false'";
              }
              {
                label = "⏻";
                type = "normal";
                command = "poweroff";
              }
              {
                label = "";
                type = "normal";
                command = "reboot";
              }
              {
                label = "󰍃";
                type = "normal";
                command = "hyprctl dispatch exit";
              }
              {
                label = "󰌾";
                type = "normal";
              }
            ];
          };

          volume = {
            label = "󰕾";
            show-per-app = true;
            show-per-app-icon = true;
            show-per-app-label = true;
            empty-list-label = "No application is sending audio";
            animation-type = "slide_down";
            animation-duration = 100;
            collapse-button-label = "";
            expand-button-label = "";
          };

          backlight = {
            label = "";
            device = "amdgpu_bl1";
          };
        };
      };
    };

    xdg.configFile = {
      "swaync/styles" = {
        enable = true;
        source = ./styles;
        recursive = true;
        force = true;
      };
    };
  };
}
