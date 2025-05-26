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
    ];
  };
}
