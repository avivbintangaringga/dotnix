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
      ayugram = enabled;
      bitwarden = enabled;
      discord = enabled;
      firefox = disabled;
      gaming = {
        all = enabled;
      };
      ghostty = disabled;
      kitty = enabled;
      libreoffice = enabled;
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
      winbox = enabled;
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
      mise = enabled;
      nvim = enabled;
      scrcpy = enabled;
      yazi = disabled;
      python = enabled;
      zsh = enabled;
      lsp = enabled;
    };

    desktop = {
      hyprland = disabled;
      mango = disabled;
      niri = enabled;
      features = {
        noctalia-shell = disabled;
        dankmaterialshell = enabled;
        quickshell = enabled;
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
            "application/x-tar"
            "application/x-gzip"
            "application/x-bzip2"
            "application/x-xz"
            "application/x-7z-compressed"
            "application/x-rar-compressed"
            "application/x-rar"
            "application/x-cpio"
            "application/x-iso9660-image"
            "application/x-debian-package"
            "application/vnd.android.package-archive"
            "application/x-redhat-package-manager"
            "application/x-zstd"
          ];
          browser = [
            "text/html"
            "x-scheme-handler/http"
            "x-scheme-handler/https"
            "x-scheme-handler/about"
            "x-scheme-handler/unknown"
          ];
          images = [
            "image/jpeg"
            "image/png"
            "image/gif"
            "image/webp"
            "image/avif"
            "image/heic"
            "image/heif"
            "image/svg+xml"
            "image/bmp"
          ];
          videos = [
            "video/mp4"
            "video/webm"
            "video/x-matroska"
            "video/quicktime"
            "video/x-msvideo"
            "video/mpeg"
            "video/ogg"
            "video/mp2t"
            "video/3gpp"
          ];
          audios = [
            "audio/mpeg"
            "audio/mp4"
            "audio/ogg"
            "audio/wav"
            "audio/x-wav"
            "audio/flac"
            "audio/x-flac"
            "audio/aac"
            "audio/webm"
            "audio/x-matroska"
            "audio/midi"
            "audio/x-midi"
            "audio/opus"
          ];
        in
        lib.mkMerge [
          {
            "inode/directory" = [ "org.gnome.Nautilus.desktop" ];
            "x-scheme-handler/discord" = [ "discord.desktop" ];
            "x-scheme-handler/terminal" = [ "kitty.desktop" ];
            "application/x-*script" = [ "org.gnome.gedit.desktop" ];
            "text/plain" = [ "org.gnome.gedit.desktop" ];
          }
          (mylib.listToAttrsSameValue browser [ "zen-beta.desktop" "thorium-browser.desktop" ])
          (mylib.listToAttrsSameValue archives [ "peazip.desktop" ])
          (mylib.listToAttrsSameValue images [ "org.kde.gwenview.desktop" "gimp.desktop" ])
          (mylib.listToAttrsSameValue videos [ "vlc.desktop" ])
          (mylib.listToAttrsSameValue audios [ "vlc.desktop" ])
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
