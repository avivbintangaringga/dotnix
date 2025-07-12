{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    setup.desktop.features.waybar.enable = lib.mkEnableOption "Waybar";
  };

  config = lib.mkIf config.setup.desktop.features.waybar.enable {
    home.packages = with pkgs; [
      brightnessctl
      networkmanagerapplet
      pavucontrol
    ];

    setup = {
      desktop.features = {
        swaync.enable = true;
      };

      apps = {
        ghostty.enable = true;
      };

      services = {
        playerctld.enable = true;
      };
    };

    programs.waybar = {
      enable = true;
      systemd.enable = true;
      style = ./style.css;
      settings = {
        topBar = {
          layer = "top";
          position = "top";
          reload_style_on_change = true;
          "backlight#icon" = {
            format = "{icon}";
            format-icons = [
              "󰃞"
              "󰃟"
              "󰃝"
              "󰃠"
            ];
          };
          "backlight#text" = {
            format = "{percent}%";
          };
          battery = {
            format = "{icon}   {capacity}%";
            format-icons = [
              ""
              ""
              ""
              ""
              ""
            ];
            format-plugged = "   {capacity}%";
            interval = 1;
            tooltip-format = "{time}";
          };
          "clock#clock" = {
            format = "{:%T}";
            interval = 1;
            timezone = "Asia/Jakarta";
            tooltip-format = "{:%T}";
          };
          "clock#date" = {
            format = "{:%A, %d %b %Y}";
            interval = 1;
            timezone = "Asia/Jakarta";
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          };
          cpu = {
            format = "   {usage}%";
            interval = 1;
          };
          "custom/notification" = {
            escape = true;
            exec = "swaync-client -swb";
            exec-if = "which swaync-client";
            format = "{icon}";
            format-icons = {
              dnd-inhibited-none = "";
              dnd-inhibited-notification = "<span foreground='red'><sub></sub></span>";
              dnd-none = "";
              dnd-notification = "<span foreground='red'><sub></sub></span>";
              inhibited-none = "";
              inhibited-notification = "<span foreground='red'><sub></sub></span>";
              none = "";
              notification = "<span foreground='red'><sub></sub></span>";
            };
            on-click = "swaync-client -t -sw";
            on-click-right = "swaync-client -d -sw";
            return-type = "json";
            tooltip = false;
          };
          "custom/revborder-left" = {
            format = " ";
          };
          "custom/revborder-mid-left" = {
            format = " ";
          };
          "custom/revborder-mid-right" = {
            format = " ";
          };
          "custom/revborder-right" = {
            format = " ";
          };
          "custom/nv-mode" = {
            exec = "nv-switch waybar";
            on-click = "nv-switch toggle";
            interval = 1;
          };
          "group/groupclock" = {
            modules = [
              "clock#date"
              "clock#clock"
            ];
            orientation = "horizontal";
          };
          "group/groupleft" = {
            modules = [
              "hyprland/workspaces"
              "tray"
            ];
            orientation = "horizontal";
          };
          "group/groupleftbg" = {
            modules = [
              "group/groupleft"
            ];
            orientation = "horizontal";
          };
          "group/groupleft2" = {
            modules = [
              "custom/nv-mode"
            ];
            orientation = "horizontal";
          };
          "group/groupleft2bg" = {
            modules = [
              "group/groupleft2"
            ];
            orientation = "horizontal";
          };
          "group/groupright" = {
            modules = [
              "temperature"
              "cpu"
              "memory"
              "network"
              "group/backlight"
              "group/volume"
              "battery"
              "custom/notification"
            ];
            orientation = "horizontal";
          };
          "group/grouprightbg" = {
            modules = [
              "group/groupright"
            ];
            orientation = "horizontal";
          };
          "group/backlight" = {
            orientation = "horizontal";
            drawer = {
              transition-left-to-right = false;
            };
            modules = [
              "backlight#icon"
              "backlight/slider"
              "backlight#text"
            ];
          };
          "group/volume" = {
            orientation = "horizontal";
            drawer = {
              transition-left-to-right = false;
            };
            modules = [
              "wireplumber#icon"
              "pulseaudio/slider"
              "wireplumber#text"
            ];
          };
          "hyprland/workspaces" = {
            persistent-workspaces = {
              "*" = [
                1
                2
                3
                4
                5
              ];
            };
          };
          memory = {
            format = "   {percentage}%";
            interval = 1;
          };
          modules-center = [
            "custom/revborder-mid-left"
            "group/groupclock"
            "custom/revborder-mid-right"
          ];
          modules-left = [
            "group/groupleftbg"
            # "custom/revborder-left"
            "group/groupleft2bg"
            "hyprland/window"
          ];
          modules-right = [
            "mpris"
            # "custom/revborder-right"
            "group/grouprightbg"
          ];
          mpris = {
            artist-len = 20;
            format = "{title} - {artist} {player_icon}";
            format-paused = "{title} - {artist} {status_icon}";
            interval = 1;
            player-icons = {
              default = "▶";
              mpv = "🎵";
            };
            status-icons = {
              paused = "⏸";
            };
            title-len = 30;
          };
          network = {
            format = "  {bandwidthTotalBytes}";
            format-disconnected = "󰀦  Disconnected";
            format-ethernet = "   {bandwidthTotalBytes}";
            format-icons = [
              "󰤯"
              "󰤟"
              "󰤢"
              "󰤥"
              "󰤨"
            ];
            format-linked = "󰪎  No Internet";
            format-wifi = "{icon}   {bandwidthTotalBytes}";
            interval = 1;
            on-click = "ghostty -e nmtui-connect";
            on-click-right = "nm-connection-editor";
            tooltip-format = "{ifname}: {ipaddr}";
          };
          "wireplumber#text" = {
            format = "{volume}%";
            format-muted = "Muted";
          };
          "wireplumber#icon" = {
            format = "{icon}";
            format-icons = [
              ""
              ""
              ""
            ];
            format-muted = "";
            on-click = "pavucontrol";
          };
          "wlr/taskbar" = {
            on-click = "activate";
            tooltop = "{title}";
            sort-by-app-id = true;
          };
          "pulseaudio/slider" = {
            orientation = "horizontal";
            min = 0;
            max = 100;
          };
          tray = {
            spacing = 10;
          };
          temperature = {
            format = "{icon} {temperatureC}°C";
            critical-threshold = 80;
            interval = 2;
            format-icons = [
              ""
              ""
              ""
              ""
              ""
            ];
          };
        };
      };

      
      # style = ./style.css;
      # settings = {
      #   topBar = {
      #     layer = "top";
      #     position = "top";
      #     reload_style_on_change = true;

      #     modules-left = [
      #       "group/groupleftbg"
      #       "custom/revborder-left"
      #       "hyprland/window"
      #     ];

      #     modules-center = [
      #       "custom/revborder-mid-left"
      #       "group/groupclock"
      #       "custom/revborder-mid-right"
      #     ];

      #     modules-right = [
      #       "mpris"
      #       "custom/revborder-right"
      #       "group/grouprightbg"
      #     ];

      #     "group/groupclock" = {
      #       orientation = "horizontal";
      #       modules = [
      #         "clock#date"
      #         "clock#clock"
      #       ];
      #     };

      #     "group/groupleft" = {
      #       orientation = "horizontal";
      #       modules = [
      #         "hyprland/workspaces"
      #         "wlr/taskbar"
      #       ];
      #     };

      #     "group/groupleftbg" = {
      #       orientation = "horizontal";
      #       modules = [
      #         "group/groupleft"
      #       ];
      #     };

      #     "group/groupright" = {
      #       orientation = "horizontal";
      #       modules = [
      #         "cpu"
      #         "memory"
      #         "network"
      #         "backlight"
      #         "wireplumber"
      #         "battery"
      #         "custom/notification"
      #       ];
      #     };

      #     "group/grouprightbg" = {
      #       orientation = "horizontal";
      #       modules = [
      #         "group/groupright"
      #       ];
      #     };

      #     "custom/revborder-mid-left" = {
      #       format = " ";
      #     };

      #     "custom/revborder-mid-right" = {
      #       format = " ";
      #     };

      #     "custom/revborder-left" = {
      #       format = " ";
      #     };

      #     "custom/revborder-right" = {
      #       format = " ";
      #     };

      #     "custom/notification" = {
      #       tooltip = false;
      #       format = "{icon}";
      #       format-icons = {
      #         notification = "<span foreground='red'><sub></sub></span>";
      #         none = "";
      #         dnd-notification = "<span foreground='red'><sub></sub></span>";
      #         dnd-none = "";
      #         inhibited-notification = "<span foreground='red'><sub></sub></span>";
      #         inhibited-none = "";
      #         dnd-inhibited-notification = "<span foreground='red'><sub></sub></span>";
      #         dnd-inhibited-none = "";
      #       };
      #       return-type = "json";
      #       exec-if = "which swaync-client";
      #       exec = "swaync-client -swb";
      #       on-click = "swaync-client -t -sw";
      #       on-click-right = "swaync-client -d -sw";
      #       escape = true;
      #     };

      #     cpu = {
      #       interval = 1;
      #       format = "   {usage}%";
      #     };

      #     memory = {
      #       interval = 1;
      #       format = "   {percentage}%";
      #     };

      #     battery = {
      #       interval = 1;
      #       tooltip-format = "{time}";
      #       format = "{icon}   {capacity}%";
      #       format-icons = [
      #         ""
      #         ""
      #         ""
      #         ""
      #         ""
      #       ];
      #       format-plugged = "   {capacity}%";
      #     };

      #     backlight = {
      #       format-icons = [
      #         "󰃞"
      #         "󰃟"
      #         "󰃝"
      #         "󰃠"
      #       ];
      #       format = "{icon}   {percent}%";
      #     };

      #     wireplumber = {
      #       format-icons = [
      #         ""
      #         ""
      #         ""
      #       ];
      #       format = "{icon}   {volume}%";
      #       format-muted = "    {volume}%";
      #       on-click = "pavucontrol";
      #     };

      #     "clock#date" = {
      #       tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      #       format = "{:%A, %d %b %Y}";
      #       timezone = "Asia/Jakarta";
      #       interval = 1;
      #     };

      #     "clock#clock" = {
      #       tooltip-format = "{:%T}";
      #       format = "{:%T}";
      #       timezone = "Asia/Jakarta";
      #       interval = 1;
      #     };

      #     network = {
      #       interval = 1;
      #       format = "  {bandwidthTotalBytes}";
      #       format-ethernet = "   {bandwidthTotalBytes}";
      #       format-wifi = "{icon}   {bandwidthTotalBytes}";
      #       format-icons = [
      #         "󰤯"
      #         "󰤟"
      #         "󰤢"
      #         "󰤥"
      #         "󰤨"
      #       ];
      #       format-disconnected = "󰀦  Disconnected";
      #       format-linked = "󰪎  No Internet";
      #       tooltip-format = "{ifname}: {ipaddr}";
      #       on-click = "kitty -e nmtui-connect";
      #       on-click-right = "nm-connection-editor";
      #     };

      #     "wlr/taskbar" = {
      #       on-click = "activate";
      #       tooltop = "{title}";
      #     };

      #     mpris = {
      #       interval = 1;
      #       format = "{title} - {artist} {player_icon}";
      #       format-paused = "{title} - {artist} {status_icon}";
      #       title-len = 30;
      #       artist-len = 20;
      #       player-icons = {
      #         default = "▶";
      #         mpv = "🎵";
      #       };
      #       status-icons = {
      #         paused = "⏸";
      #       };
      #     };

      #     "hyprland/workspaces" = {
      #       persistent-workspaces = {
      #         "*" = [
      #           1
      #           2
      #           3
      #           4
      #           5
      #         ];
      #       };
      #     };
      #   };
      # };
    };
  };
}
