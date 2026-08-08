{
  dotnix.nix-ld.nixos = { pkgs, options, ... }: {
    programs.nix-ld = {
      enable = true;
      libraries =
        options.programs.nix-ld.libraries.default
        ++ (with pkgs; [
          glib
          nss
          nspr
          dbus
          atk
          cups
          gtk3
          pango
          cairo
          libx11
          libxcomposite
          libxdamage
          libxext
          libxtst
          libxrender
          libxi
          libxfixes
          libxrandr
          libxcb
          libdrm
          freetype
          fontconfig
          mesa
          alsa-lib
          zlib
          libGL
          udev
          libgbm
          expat
          libxkbcommon
          gnome.gvfs
          harfbuzzFull
        ]);
    };
  };
}
