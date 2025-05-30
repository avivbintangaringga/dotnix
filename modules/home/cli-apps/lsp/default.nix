{
  lib,
  config,
  pkgs,
  ...
}:
{
  options = {
    setup.cli-apps.lsp.enable = lib.mkEnableOption "LSP";
  };

  config = lib.mkIf config.setup.cli-apps.lsp.enable {
    home.packages = with pkgs; [
      nixd
      nil
      nixfmt-rfc-style

      gopls
      vscode-langservers-extracted
      typescript-language-server
      taplo  # TOML
      bash-language-server
      docker-compose-language-service
      docker-language-server
      ruff  # Python
      vue-language-server
      yaml-language-server
    ];
  };
}
