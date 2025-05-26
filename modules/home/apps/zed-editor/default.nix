{ lib, config, ... }:
{
  options = {
    setup.apps.zed-editor.enable = lib.mkEnableOption "Zed Editor";
  };

  config = lib.mkIf config.setup.apps.zed-editor.enable {
    programs.zed-editor = {
      enable = true;
      extensions = [
        "github-theme"
        "github-dark-default"
        "catppuccin"
      ];
      userSettings = {
        assistant = {
          default_model = {
            provider = "ollama";
            model = "qwen2.5-coder-3b";
          };
          version = 2;
        };
        icon_theme = "Catppuccin Macchiato";
        features = {
          edit_prediction_provider = "none";
        };
        theme = {
          mode = "dark";
          light = "One Light";
          dark = "Catppuccin Macchiato";
        };
        show_edit_predictions = false;
        vim_mode = true;
        cursor_blink = false;
        ui_font_size = 16;
        buffer_font_size = 16;
        current_line_highlight = "gutter";
        show_wrap_guides = true;
        wrap_guides = [80];
        relative_line_numbers = true;
        scrollbar = {
          axes = {
            horizontal = false;
          };
        };
        indent_guides = {
          coloring = "fixed";
        };
        telemetry = {
          diagnostics = false;
          metrics = false;
        };
        auto_update = false;
        vim = {
          toggle_relative_line_numbers = true;
        };
      };
    };
  };
}
