{ lib, config, pkgs, ... }:
{
  options = {
    setup.desktop.features.waybar.enable = lib.mkEnableOption "Waybar";
  };

  config = lib.mkIf config.setup.desktop.features.waybar.enable {
    home.packages = with pkgs; [
      brightnessctld
      networkmanagerapplet
      pavucontrol
    ];

    setup = {
      desktop.features = {
        swaync.enable = true;
      };

      apps = {
        kitty.enable = true;
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

	        modules-left = [
	          "group/groupleftbg"
	          "custom/revborder-left"
	          "hyprland/window"
	        ];

	        modules-center = [
	          "custom/revborder-mid-left"
            "group/groupclock"
	          "custom/revborder-mid-right"
	        ];

	        modules-right = [
	          "mpris"
	          "custom/revborder-right"
	          "group/grouprightbg"
	        ];

	        "group/groupclock" = {
            orientation = "horizontal";
	          modules = [
              "clock#date"
              "clock#clock"
	          ];
	        };

	        "group/groupleft" = {
            orientation = "horizontal";
	          modules = [
              "hyprland/workspaces"
	            "wlr/taskbar"
	          ];
	        };

	        "group/groupleftbg" = {
            orientation = "horizontal";
	          modules = [
	            "group/groupleft"
	          ];
	        };

	        "group/groupright" = {
            orientation = "horizontal";
	          modules = [
              "cpu"
	            "memory"
	            "network"
              "backlight"
	            "wireplumber"
	            "battery"
	            "custom/notification"
	          ];
	        };

	        "group/grouprightbg" = {
            orientation = "horizontal";
	          modules = [
	           "group/groupright"
	          ];
	        };

	        "custom/revborder-mid-left" = {
            format = " ";
	        };

	        "custom/revborder-mid-right" = {
            format = " ";
	        };

	        "custom/revborder-left" = {
            format = " ";
	        };

	        "custom/revborder-right" = {
            format = " ";
	        };

          "custom/notification" = {
            tooltip = false;
            format = "{icon}";
            format-icons = {
              notification = "<span foreground='red'><sub></sub></span>";
              none = "";
              dnd-notification = "<span foreground='red'><sub></sub></span>";
              dnd-none = "";
              inhibited-notification = "<span foreground='red'><sub></sub></span>";
              inhibited-none = "";
              dnd-inhibited-notification = "<span foreground='red'><sub></sub></span>";
              dnd-inhibited-none = "";
            };
            return-type = "json";
            exec-if = "which swaync-client";
            exec = "swaync-client -swb";
            on-click = "swaync-client -t -sw";
            on-click-right = "swaync-client -d -sw";
            escape = true;
          };

	        cpu = {
            interval = 1;
	          format = "   {usage}%";
	        };

	        memory = {
            interval = 1;
	          format = "   {percentage}%";
	        };

          battery = {
            interval = 1;
	          tooltip-format = "{time}";
	          format = "{icon}   {capacity}%";
	          format-icons = ["" "" "" "" ""];
	          format-plugged = "   {capacity}%";
	        };

	        backlight = {
            format-icons = [ "󰃞" "󰃟" "󰃝" "󰃠" ];
	          format = "{icon}   {percent}%";
	        };

	        wireplumber = {
            format-icons = [ "" "" "" ];
	          format = "{icon}   {volume}%";
            format-muted = "    {volume}%";
            on-click = "pavucontrol";
	        };

	        "clock#date" = {
            tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
	          format = "{:%A, %d %b %Y}";
	          timezone = "Asia/Jakarta";
	          interval = 1;
	        };

	        "clock#clock" = {
            tooltip-format = "{:%T}";
	          format = "{:%T}";
	          timezone = "Asia/Jakarta";
	          interval = 1;
	        };

	        network = {
	          interval = 1;
            format = "  {bandwidthTotalBytes}";
            format-ethernet = "   {bandwidthTotalBytes}";
            format-wifi = "{icon}   {bandwidthTotalBytes}";
	          format-icons = ["󰤯" "󰤟" "󰤢" "󰤥" "󰤨"];
            format-disconnected = "󰀦  Disconnected";
            format-linked = "󰪎  No Internet";
	          tooltip-format = "{ifname}: {ipaddr}";
	          on-click = "kitty -e nmtui-connect";
	          on-click-right = "nm-connection-editor";
	        };

	        "wlr/taskbar" = {
            on-click = "activate";
	           tooltop = "{title}";
	        };

          mpris = {
	          interval = 1;
	          format = "{title} - {artist} {player_icon}";
	          format-paused = "{title} - {artist} {status_icon}";
	          title-len = 30;
	          artist-len = 20;
	          player-icons = {
              default = "▶";
              mpv = "🎵";
	          };
	          status-icons = {
	            paused = "⏸";
	          };
	        };

	        "hyprland/workspaces" = {
            persistent-workspaces = {
              "*" = [ 1 2 3 4 5 ];
            };
          };
        };
      };
    };
  };
}
