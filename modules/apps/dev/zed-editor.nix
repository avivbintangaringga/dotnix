{
  dotnix.zed-editor.homeManager.programs.zed-editor =
    let
      theme = "Adaptify Darker";
      icon-theme = "Material Icon Theme";
    in
    {
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
        "tokyo-night"
        "one-dark-pro-enhanced"

        "color-hightlight"
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
        "emmet"
        "fastapi-snippets"
        "git-firefly"
        "github-actions"
        "go-snippets"
        "golangci-link"
        "gosum"
        "gotmpl"
        "hyprlang"
        "ini"
        "java"
        "java-eclipse-jdtls"
        "javascript-snippets"
        "just"
        "just-ls"
        "kdl"
        "kotlin"
        "less"
        "lua"
        "luau"
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
        "qml"
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
      mutableUserKeymaps = false;
      mutableUserSettings = false;
      mutableUserTasks = false;
      userSettings = {
        active_pane_modifiers = {
          border_size = 1.0;
          inactive_opacity = 0.6;
        };
        auto_update = false;
        autosave = "off";
        buffer_font_size = 14;
        colorize_brackets = true;
        current_line_highlight = "gutter";
        cursor_blink = false;
        disable_ai = false;
        edit_predictions.mode = "subtle";
        hover_popover_delay = 250;
        icon_theme = {
          "dark" = icon-theme;
          "light" = icon-theme;
          "mode" = "dark";
        };
        indent_guides = {
          coloring = "indent_aware";
          enabled = true;
        };
        inlay_hints.enabled = false;
        language_models.openai_compatible."LLM7" = {
          api_url = "https://api.llm7.io/v1";
          available_models = [
            {
              display_name = "Codestral Latest (LLM7)";
              max_tokens = 1000000;
              name = "codestral-latest";
            }
          ];
        };
        languages = {
          Java = {
            formatter = "language_server";
            language_servers = [ "jdtls" ];
          };
          Lua.hard_tabs = true;
          Luau = {
            formatter.external = {
              arguments = [ "-" ];
              command = "stylua";
            };
            hard_tabs = true;
          };
          Nix = {
            format_on_save = "on";
            formatter.external = {
              arguments = [
                "-"
              ];
              command = "pedantix";
            };
          };
          Templ.language_servers = [
            "templ"
            "tailwindcss-language-server"
            "emmet-language-server"
          ];
        };
        lsp = {
          emmet-language-server.settings.includeLanguages.templ = "html";
          luau-lsp.settings.completion.autocompleteEnd = true;
          tailwindcss-language-server.settings = {
            experimental.classRegex = [
              "class=\"([^\"]*)\""
              "className=\"([^\"]*)\""
            ];
            includeLanguages.templ = "html";
          };
        };
        minimap = {
          current_line_highlight = "all";
          show = "always";
        };
        project_panel.dock = "right";
        relative_line_numbers = "wrapped";
        scrollbar.axes.horizontal = false;
        show_edit_predictions = true;
        show_wrap_guides = true;
        tabs = {
          file_icons = true;
          git_status = true;
          show_diagnostics = "errors";
        };
        telemetry = {
          diagnostics = false;
          metrics = false;
        };
        theme = {
          "dark" = theme;
          "light" = theme;
          "mode" = "dark";
        };
        ui_font_size = 15;
        vim.toggle_relative_line_numbers = true;
        vim_mode = true;
        which_key.enabled = true;
        wrap_guides = [ 80 ];
      };
    };
}
