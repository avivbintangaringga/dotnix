{ lib, config, ... }:
{
  options = {
    setup.apps.zed-editor.enable = lib.mkEnableOption "Zed Editor";
  };

  config = lib.mkIf config.setup.apps.zed-editor.enable {
    programs.zed-editor = let
        theme = "Catppuccin Espresso (Blur)";
        icon-theme = "Material Icon Theme";
      in {
      enable = true;
      extensions = [
        # Themes
        "adaptify"
        "github-theme"
        "github-dark-default"
        "catppuccin"
        "catppuccin-blur"
        "catppuccin-blur-plus"
        "catppuccin-icons"

        "color-hightlight"
        "alpinejs-snippets"
        "html-snippets"
        "comment"
        "csharp"
        "csharp-snippets"
        "css-modules-kit"
        "csv"
        "desktop"
        "docker-compose"
        "dockerfile"
        "caddyfile"
        "emoji-completions"
        "fastapi-snippets"
        "fiber-snippets"
        "fish"
        "git-firefly"
        "github-actions"
        "go-snippets"
        "golangci-link"
        "gosum"
        "gotmpl"
        "hyprlang"
        "ini"
        "java"
        "javascript-snippets"
        "just"
        "just-ls"
        "kdl"
        "kotlin"
        "less"
        "lua"
        "make"
        "markdownlint"
        "material-icon-theme"
        "nix"
        "odin"
        "php"
        "php-snippets"
        "phpcs"
        "powershell"
        "python-snippets"
        "react-snippets"
        "react-type-kit-snippets"
        "react-typescript-snippets"
        "rust-snippets"
        "sql"
        "sqlc-snippets"
        "ssh-config"
        "templ"
        "tmux"
        "todotxt"
        "toml"
        "typescript-snippets"
        "v"
        "vue"
        "vue-snippets"
        "xml"
        "zig"

      ];
      mutableUserTasks = false;
      mutableUserSettings = false;
      mutableUserKeymaps = false;
      userSettings = {
        active_pane_modifiers = {
          border_size = 2.0;
          inactive_opacity = 0.6;
        };

        autosave = {
          "after_delay" = {
            "milliseconds" = 1000;
          };
        };

        auto_update = false;
        disable_ai = false;
        
        minimap = {
          show = "always";
          current_line_highlight = "all";
        };

        tabs = {
          file_icons = true;
          git_status = true;
          show_diagnostics = "errors";
        };

        features = {
          "edit_prediction_provider" = "zed";
        };

        indent_guides = {
          enabled = true;
          coloring = "indent_aware";
        };

        hover_popover_delay = 100;
        icon_theme = {
          "mode" = "dark";
          "dark" = icon-theme;
          "light" = icon-theme;
        };

        inlay_hints = {
          enabled = true;
          
        };

        theme = {
          "mode" = "dark";
          "dark" = theme;
          "light" = theme;
        };

        
        show_edit_predictions = true;
        vim_mode = true;
        cursor_blink = false;
        ui_font_size = 16;
        buffer_font_size = 16;
        current_line_highlight = "gutter";
        show_wrap_guides = true;
        wrap_guides = [ 80 ];
        relative_line_numbers = true;
        scrollbar = {
          axes = {
            horizontal = false;
          };
        };
        telemetry = {
          diagnostics = false;
          metrics = false;
        };
        vim = {
          toggle_relative_line_numbers = true;
        };
      };
    };
  };
}
