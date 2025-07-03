{
  lib,
  config,
  pkgs,
  userdata,
  ...
}:
{
  options.setup.apps.vscode.enable = lib.mkEnableOption "VSCode";
  config = lib.mkIf config.setup.apps.vscode.enable {
    programs.vscode = {
      enable = true;
      profiles = {
        "${userdata.username}" = {
          extensions = with pkgs.vscode-extensions; [
            ms-python.python
            ms-python.vscode-pylance
            ms-python.debugpy

            ms-azuretools.vscode-docker
            eamodio.gitlens
            github.github-vscode-theme
            pkief.material-icon-theme

            golang.go
            zainchen.json
            dbaeumer.vscode-eslint
            bradlc.vscode-tailwindcss
            
            esbenp.prettier-vscode
            ms-vscode-remote.remote-ssh
            ms-vscode-remote.remote-ssh-edit

            formulahendry.auto-close-tag
            formulahendry.auto-rename-tag
          ];
        };
      };
    };
  };
}
