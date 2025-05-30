{
  lib,
  config,
  pkgs,
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
      settings = {
        theme = "base16_default";
        editor = {
          line-number = "relative";
          undercurl = true;
          bufferline = "multiple";
          popup-border = "all";
          statusline = {
            mode = {
              normal = "NORMAL";
              insert = "INSERT";
              select = "SELECT";
            };
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
