{ lib, config, inputs, mylib, ... }:
let
  inherit (mylib) enabled;
in
{
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];

  options = {
    setup.cli-apps.nvim.enable = lib.mkEnableOption "NVim";
  };

  config = lib.mkIf config.setup.cli-apps.nvim.enable {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;

      colorschemes = {
        catppuccin.enable = true;
      };

      plugins = {
        lualine = enabled;
        treesitter = enabled;
        telescope = enabled;
        web-devicons = enabled;

        lsp = {
          servers = {
            cssls = enabled;
	          nixd = enabled;
	          gopls = enabled;
	        };
        };
      };
    };
  };
}
