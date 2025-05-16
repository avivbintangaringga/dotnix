{
  services.swaync = {
    enable = true;
    #style = ./style.css;
    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      cssPriority = "user";
      control-center-margin-top = 20;
      control-center-margin-bottom = 20;
      control-center-margin-right = 20;
      control-center-layer = "top";
      control-center-exclusive-zone = false;
      notification-2fa-action = true;
      timeout = 5;
      timeout-low = 3;
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
               label = " ";
               type = "normal";
             }
             {
               label = "󰂯";
               type = "normal";
             }
             {
               label = "󰝟";
               type = "toggle";
             }
             {
               label = "";
               type = "toggle";
             }
             {
               label = "⏻";
               type = "normal";
             }
             {
               label = "";
               type = "normal";
             }
             {
               label = "󰍃";
               type = "normal";
             }
             {
               label = "";
               type = "normal";
             }
           ];
         };
         
         volume = {
           label = "";
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
       source = ./styles;
       recursive = true;
       force = true;
    };
  };
}
