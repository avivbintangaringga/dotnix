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
          userSettings = {
            files = {
              autoSave = "afterDelay";
              autoSaveDelay = 1000;
            };
            terminal = {
              integrated = {
                fontFamily = "FiraCode Nerd Font";
                fontLigatures.enabled = true;
                gpuAcceleration = "auto";
              };
            };
          };
          extensions = with pkgs.vscode-extensions; [
            # ms-python.python
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
            vscodevim.vim
        
            esbenp.prettier-vscode
            ms-vscode-remote.remote-ssh
            ms-vscode-remote.remote-ssh-edit

            formulahendry.auto-close-tag
            formulahendry.auto-rename-tag

            ecmel.vscode-html-css
            vue.volar
            vue.vscode-typescript-vue-plugin

          ];
        };
      };
    };
  };
}
