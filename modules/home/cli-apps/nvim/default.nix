{ lib, config, inputs, ... }:
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
        lualine = {
          enable = true;
        };

        treesitter = {
          enable = true;
        };

        telescope = {
          enable = true;
        };

        lsp = {
          servers = {
            cssls = {
	            enable = true;
	          };
	          nixd = {
              enable = true;
	          };
	          gopls = {
	            enable = true;
	          };
	        };
        };
      };
    };
  };
}
