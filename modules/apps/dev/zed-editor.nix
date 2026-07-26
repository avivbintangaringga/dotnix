{
  dotnix.zed-editor = {
    homeManager = {
      programs.zed-editor = let
          theme = "Adaptify Darker";
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
        mutableUserTasks = false;
        mutableUserSettings = false;
        mutableUserKeymaps = false;
        userSettings = {
          active_pane_modifiers = {
            border_size = 1.0;
            inactive_opacity = 0.6;
          };

          autosave = "off";
          auto_update = false;
          colorize_brackets = true;

          disable_ai = false;
          show_edit_predictions = true;
          edit_predictions = {
            mode = "subtle";
          };
          language_models = {
            openai_compatible = {
              "LLM7" = {
                api_url = "https://api.llm7.io/v1";
                available_models = [
                  {
                    name = "codestral-latest";
                    display_name = "Codestral Latest (LLM7)";
                    max_tokens = 1000000;
                  }
                ];
              };
            };
          };

          minimap = {
            show = "always";
            current_line_highlight = "all";
          };

          tabs = {
            file_icons = true;
            git_status = true;
            show_diagnostics = "errors";
          };

          indent_guides = {
            enabled = true;
            coloring = "indent_aware";
          };

          hover_popover_delay = 250;
          icon_theme = {
            "mode" = "dark";
            "dark" = icon-theme;
            "light" = icon-theme;
          };

          inlay_hints = {
            enabled = false;

          };

          project_panel = {
            dock = "right";
          };

          theme = {
            "mode" = "dark";
            "dark" = theme;
            "light" = theme;
          };

          vim_mode = true;
          cursor_blink = false;
          ui_font_size = 15;
          buffer_font_size = 14;
          current_line_highlight = "gutter";
          show_wrap_guides = true;
          wrap_guides = [ 80 ];
          relative_line_numbers = "wrapped";
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

          which_key = {
            enabled = true;
          };

          languages = {
            Templ = {
              language_servers = [
                "templ"
                "tailwindcss-language-server"
                "emmet-language-server"
              ];
            };

            Java = {
              language_servers = [ "jdtls" ];
              formatter = "language_server";
            };

            Lua = {
              hard_tabs = true;
            };

            Luau = {
              hard_tabs = true;
              formatter = {
                external = {
                  command = "stylua";
                  arguments = [ "-" ];
                };
              };
            };
          };

          lsp = {
            tailwindcss-language-server = {
              settings = {
                includeLanguages = {
                  templ = "html";
                };
                experimental = {
                  classRegex = [
                    "class=\"([^\"]*)\""
                    "className=\"([^\"]*)\""
                  ];
                };
              };
            };

            emmet-language-server = {
              settings = {
                includeLanguages = {
                  templ = "html";
                };
              };
            };

            luau-lsp = {
              settings = {
                completion = {
                  autocompleteEnd = true;
                };
              };
            };
          };
        };
      };
    };
  };
}
