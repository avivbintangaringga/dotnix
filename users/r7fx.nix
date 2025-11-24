{
  userdata,
  mylib,
  pkgs,
  lib,
  ...
}:
let
  inherit (mylib) enabled disabled;
in
{
  imports = [
    ./common.nix
    ./../modules/home/import.nix
    ./../overlays/import.nix
  ];

  setup = {
    apps = {
      android-studio = enabled;
      ayugram = disabled;
      bitwarden = enabled;
      discord = enabled;
      firefox = disabled;
      gaming = {
        all = enabled;
      };
      ghostty = disabled;
      kitty = enabled;
      looking-glass-client = enabled;
      mediaplayer = enabled;
      moonlight = enabled;
      misc = enabled;
      nemo = disabled;
      obs-studio = enabled;
      onlyoffice = enabled;
      peazip = enabled;
      postman = enabled;
      qbittorrent = enabled;
      quickemu = disabled;
      spicetify = enabled;
      thorium-browser = enabled;
      vscode = enabled;
      zed-editor = enabled;
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
      hyprland = disabled;
      mango = enabled;
      niri = enabled;
      features = {
        noctalia-shell = disabled;
        dankmaterialshell = enabled;
      };
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
    configFile = {
      "mimeapps.list".force = true;
      # "gtk-3.0/settings.ini".force = true;
      # "gtk-4.0/gtk.css".force = true;
    };

    terminal-exec = {
      enable = true;
      package = pkgs.kitty;
    };

    mimeApps = {
      defaultApplications =
        let
          archives = [
            "application/zip"
            "application/vnd.rar"
          ];
          browser = [
            "text/html"
            "x-scheme-handler/http"
            "x-scheme-handler/https"
            "x-scheme-handler/about"
            "x-scheme-handler/unknown"
          ];
        in
        lib.mkMerge [
          {
            "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
            "x-scheme-handler/discord" = [ "discord.desktop" ];
          }
          (mylib.listToAttrsSameValue browser [ "zen-beta.desktop" ])
          (mylib.listToAttrsSameValue archives [ "peazip.desktop" ])
        ];
    };

    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = with pkgs; [
        # xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
        # xdg-desktop-portal-wlr
        # xdg-desktop-portal-gtk
        # xdg-desktop-portal-hyprland
        # kdePackages.xdg-desktop-portal-kde
      ];
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
