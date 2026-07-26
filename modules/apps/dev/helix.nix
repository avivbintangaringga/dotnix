{
  dotnix.helix = {
    homeManager = {
      programs.helix = {
        enable = true;
        settings = {
          editor = {
            bufferline = "multiple";
            color-modes = true;
            cursor-shape = {
              insert = "bar";
            };
            indent-guides = {
              character = "▏";
              render = true;
              skip-levels = 0;
            };
            inline-diagnostics = {
              cursor-line = "warning";
              other-lines = "error";
            };
            line-number = "relative";
            popup-border = "all";
            soft-wrap = {
              enable = true;
            };
            statusline = {
              left = [
                "mode"
                "spinner"
                "version-control"
                "file-name"
                "read-only-indicator"
                "file-modification-indicator"
              ];
              mode = {
                insert = "INSERT";
                normal = "NORMAL";
                select = "SELECT";
              };
              separator = "│";
            };
            undercurl = true;
          };
          keys = {
            normal = {
              esc = [
                "collapse_selection"
                "keep_primary_selection"
              ];
            };
          };
          theme = "tokyonight-transparent";
        };
        themes = {
          tokyonight-transparent = {
            inherits = "github_dark";
            "ui.background" = { };
          };
        };
      };
    };

    nixos = { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        helix
      ];
    };
  };
}
