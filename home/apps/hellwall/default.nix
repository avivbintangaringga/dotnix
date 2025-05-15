{ pkgs, ... }:
let
  tpl-path = ''~/.config/hellwal/templates/'';
  hypr-colors = ''
    $background = rgb(%%background%%)
    $foreground = rgb(%%foreground%%)

    $color0 = rgb(%%color0%%)
    $color1 = rgb(%%color1%%)
    $color2 = rgb(%%color2%%)
    $color3 = rgb(%%color3%%)
    $color4 = rgb(%%color4%%)
    $color5 = rgb(%%color5%%)
    $color6 = rgb(%%color6%%)
    $color7 = rgb(%%color7%%)
    $color8 = rgb(%%color8%%)
    $color9 = rgb(%%color9%%)
    $color10 = rgb(%%color10%%)
    $color11 = rgb(%%color11%%)
    $color12 = rgb(%%color12%%)
    $color13 = rgb(%%color13%%)
    $color14 = rgb(%%color14%%)
    $color15 = rgb(%%color15%%)
  '';
  waybar-colors = ''
    @define-color foreground #%%foreground%%;
    @define-color background #%%background%%;
    @define-color cursor #%%cursor%%;
    @define-color color0 #%%color0%%;
    @define-color color1 #%%color1%%;
    @define-color color2 #%%color2%%;
    @define-color color3 #%%color3%%;
    @define-color color4 #%%color4%%;
    @define-color color5 #%%color5%%;
    @define-color color6 #%%color6%%;
    @define-color color7 #%%color7%%;
    @define-color color8 #%%color8%%;
    @define-color color9 #%%color9%%;
    @define-color color10 #%%color10%%;
    @define-color color11 #%%color11%%;
    @define-color color12 #%%color12%%;
    @define-color color13 #%%color13%%;
    @define-color color14 #%%color14%%;
    @define-color color15 #%%color15%%;
  '';
  discord-colors = ''
    --background: #%% background.hex %%;
    --foreground: #%% foreground.hex %%;
    --cursor: #%% cursor.hex %%;
    --border: #%% border.hex %%;
    
    --color0: #%% color0.hex %%;
    --color1: #%% color1.hex %%;
    --color2: #%% color2.hex %%;
    --color3: #%% color3.hex %%;
    --color4: #%% color4.hex %%;
    --color5: #%% color5.hex %%;
    --color6: #%% color6.hex %%;
    --color7: #%% color7.hex %%;
    --color8: #%% color8.hex %%;
    --color9: #%% color9.hex %%;
    --color10: #%% color10.hex %%;
    --color11: #%% color11.hex %%;
    --color12: #%% color12.hex %%;
    --color13: #%% color13.hex %%;
    --color14: #%% color14.hex %%;
    --color15: #%% color15.hex %%;
  '';
  wofi-colors = ''
      window {
        margin: 0px;
        border: 1px solid #%%foreground.rgb%%;
        background-color: #%%background.rgb%%;
      }

      #input {
        margin: 5px;
        border: none;
        background-color: #%%color8.rgb%%;
      }

      #inner-box {
        margin: 5px;
        border: none;
        background-color: #%%background.rgb%%;
      }

      #outer-box {
        margin: 5px;
        border: none;
        background-color: #%%background.rgb%%;
      }

      #scroll {
        margin: 0px;
        border: none;
      }

      #text {
        margin: 5px;
        border: none;
        color: #ffffff;
      }

      #entry:selected {
        background-color: #%%color8.rgb%%;
      }
    '';
    terminal-colors = ''
      # Colors from 0-15
      printf "\033]4;0;#%%color0.hex%%\033\\"
      printf "\033]4;1;#%%color1.hex%%\033\\"
      printf "\033]4;2;#%%color2.hex%%\033\\"
      printf "\033]4;3;#%%color3.hex%%\033\\"
      printf "\033]4;4;#%%color4.hex%%\033\\"
      printf "\033]4;5;#%%color5.hex%%\033\\"
      printf "\033]4;6;#%%color6.hex%%\033\\"
      printf "\033]4;7;#%%color7.hex%%\033\\"
      printf "\033]4;8;#%%color8.hex%%\033\\"
      printf "\033]4;9;#%%color9.hex%%\033\\"
      printf "\033]4;10;#%%color10.hex%%\033\\"
      printf "\033]4;11;#%%color11.hex%%\033\\"
      printf "\033]4;12;#%%color12.hex%%\033\\"
      printf "\033]4;13;#%%color13.hex%%\033\\"
      printf "\033]4;14;#%%color14.hex%%\033\\"
      printf "\033]4;15;#%%color15.hex%%\033\\"
      
      # Background
      printf "\033]11;#%%background%%\033\\";
      
      # Foreground
      printf "\033]10;#%%foreground%%\033\\";
      
      # Cursor
      printf "\033]12;#%%cursor%%\033\\";
      
      # Border
      printf "\033]7044;#%%border%%\033\\";
    '';
in {
  home.activation.copy-config = ''
    mkdir -p ~/.config/hellwal/templates/ ~/.config/hellwal/themes
    mkdir -p ~/.cache/hellwal
    cp -f ${pkgs.writeText "hyprland-colors.conf" "${hypr-colors}"} ${tpl-path}/hyprland-colors.conf
    cp -f ${pkgs.writeText "waybar-colors.conf" "${waybar-colors}"} ${tpl-path}/waybar-colors.conf
    cp -f ${pkgs.writeText "terminal-colors.sh" "${terminal-colors}"} ${tpl-path}/terminal-colors.sh
  '';
}
