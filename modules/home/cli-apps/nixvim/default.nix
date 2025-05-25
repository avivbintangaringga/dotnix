{ pkgs, nixvim, ... }:
{
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

      #treesitter = {
      #  enable = true;
      #};

      #telescope = {
      #  enable = true;
      #};

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
}
