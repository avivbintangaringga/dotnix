{ lib, config, ... }:
{
  options = {
    setup.cli-apps.nvim.enable = lib.mkEnableOption "Neovim";
  };

  config = lib.mkIf config.setup.cli-apps.nvim.enable {
    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
