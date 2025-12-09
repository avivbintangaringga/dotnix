{
  lib,
  config,
  inputs,
  mylib,
  pkgs,
  ...
}:
let
  inherit (mylib) enabled;
in
{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  options = {
    setup.cli-apps.nvim.enable = lib.mkEnableOption "NVim";
  };

  config = lib.mkIf config.setup.cli-apps.nvim.enable {
    home.packages = [
      inputs.nvix.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];

    #programs.nixvim = {
    #  enable = true;
    #  defaultEditor = true;
    #  viAlias = true;
    #  vimAlias = true;

    #  colorschemes = {
    #    catppuccin.enable = true;
    #  };

    #  keymaps = [
    #    {
    #      key = ";";
    #      action = ":";
    #    }
    #  ];

    #  globals = {
    #    mapleader = " ";
    #  };

    #  opts = {
    #    tabstop = 2;
    #    tabwidth = 2;
    #    expandtab = true;
    #  };

    #  plugins = {
    #    lualine = enabled;
    #    treesitter = enabled;
    #    telescope = enabled;
    #    web-devicons = enabled;

    #    lsp = {
    #      servers = {
    #        cssls = enabled;
    #        nixd = enabled;
    #        gopls = enabled;
    #      };
    #    };
    #  };
    #};
  };
}
