{
  userdata,
  mylib,
  ...
}:
let
  inherit (mylib) enabled disabled;
in
{
  imports = [
    ./common.nix
    ./../modules/home/import.nix
  ];

  setup = {
    apps = {
      bitwarden = enabled;
      discord = enabled;
      firefox = enabled;
      gaming = {
        all = enabled;
      };
      ghostty = enabled;
      kitty = enabled;
      looking-glass-client = enabled;
      mediaplayer = enabled;
      misc = enabled;
      nemo = enabled;
      obs-studio = enabled;
      onlyoffice = enabled;
      peazip = enabled;
      postman = enabled;
      qbittorrent = enabled;
      quickemu = enabled;
      spicetify = enabled;
      thorium-browser = enabled;
      vscode = enabled;
      zed-editor = disabled;
      zen-browser = enabled;
      zotero = enabled;
    };

    cli-apps = {
      bun = enabled;
      git = enabled;
      go = enabled;
      helix = enabled;
      misc = enabled;
      nvim = enabled;
      scrcpy = enabled;
      yazi = enabled;
      python = enabled;
      zsh = enabled;
      lsp = enabled;
    };

    desktop = {
      hyprland = enabled;
    };

    services = {
      blueman = enabled;
      cliphist = enabled;
      playerctld = enabled;
    };
  };

  home = {
    username = userdata.username;
    homeDirectory = userdata.userpath;
    stateVersion = "24.11";
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "Fira Mono" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  xdg = {
    mimeApps = {
      defaultApplications = {
        "inode/directory" = [ "nemo.desktop" ];
        "x-scheme-handler/discord" = [ "discord.desktop" ];
      };
    };
  };
}
