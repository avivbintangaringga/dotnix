{
  lib,
  config,
  options,
  userdata,
  pkgs,
  ...
}:
{
  options = {
    setup.misc.nix-ld.enable = lib.mkEnableOption "nix-ld";
  };

  config = lib.mkIf config.setup.misc.nix-ld.enable {
    programs.nix-ld = {
      enable = true;
      libraries = options.programs.nix-ld.libraries.default ++ (with pkgs; [
        glib
        nss
        nspr
        dbus
        atk
        cups
        gtk3
        pango
        cairo
        xorg.libX11
        xorg.libXcomposite
        xorg.libXdamage
        xorg.libXext
        xorg.libXfixes
        xorg.libXrandr
        xorg.libxcb
        libdrm
        mesa
        alsa-lib
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
