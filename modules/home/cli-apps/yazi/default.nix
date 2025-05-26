{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    setup.cli-apps.yazi.enable = lib.mkEnableOption "Yazi";
  };

  config = lib.mkIf config.setup.cli-apps.yazi.enable {
    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
      flavors = with pkgs.yaziPlugins; {
        yatline-catppuccin = yatline-catppuccin;
      };
      plugins = with pkgs.yaziPlugins; {
        toggle-pane = toggle-pane;
        time-travel = time-travel;
        sudo = sudo;
        rich-preview = rich-preview;
        mount = mount;
        mediainfo = mediainfo;
        git = git;
        full-border = full-border;
        chmod = chmod;
      };
    };
  };
}
