{
  lib,
  config,
  ...
}:
{
  options = {
    setup.cli-apps.helix.enable = lib.mkEnableOption "Helix";
  };

  config = lib.mkIf config.setup.cli-apps.helix.enable {
    programs.helix = {
      enable = true;
      # package = pkgs.evil-helix;
      themes = {
        tokyonight-transparent = {
          inherits = "github_dark";
          "ui.background" = { };
        };
      };
      settings = {
        theme = "tokyonight-transparent";
        editor = {
          line-number = "relative";
          undercurl = true;
          color-modes = true;
          bufferline = "multiple";
          popup-border = "all";
          statusline = {
            mode = {
              normal = "NORMAL";
              insert = "INSERT";
              select = "SELECT";
            };
            separator = "│";
            left = [
              "mode"
              "spinner"
              "version-control"
              "file-name"
              "read-only-indicator"
              "file-modification-indicator"
            ];
          };
          cursor-shape = {
            insert = "bar";
          };
          indent-guides = {
            render = true;
            character = "▏";
            skip-levels = 0;
          };
          inline-diagnostics = {
            cursor-line = "warning";
            other-lines = "warning";
          };
          soft-wrap = {
            enable = true;
          };
        };
        keys = {
          normal = {
           esc = [ "collapse_selection" "keep_primary_selection" ] ;
          };
        };
      };
    };
  };
}
