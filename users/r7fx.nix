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
      firefox = disabled;
      gaming = {
        all = enabled;
      };
      gauntlet = disabled;
      ghostty = enabled;
      kitty = disabled;
      looking-glass-client = enabled;
      mediaplayer = enabled;
      misc = enabled;
      nemo = enabled;
      obs-studio = enabled;
      onlyoffice = disabled;
      peazip = enabled;
      postman = enabled;
      qbittorrent = enabled;
      quickemu = disabled;
      spicetify = enabled;
      thorium-browser = enabled;
      vscode = enabled;
      zed-editor = disabled;
      zen-browser = enabled;
      zotero = disabled;
    };

    cli-apps = {
      bun = enabled;
      git = enabled;
      go = enabled;
      helix = enabled;
      misc = enabled;
      nvim = enabled;
      scrcpy = enabled;
      yazi = disabled;
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

    desktopEntries = {
      win11 = {
        name = "Windows 11";
        icon = ../assets/icons/windows11.png;
        exec = "vm-start win11";
        terminal = false;
        type = "Application";
        categories = [ "System" ];
      };
    };
  };
}
