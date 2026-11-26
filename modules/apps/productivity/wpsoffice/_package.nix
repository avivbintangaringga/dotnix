{
  bash,
  makeWrapper,
  openbox,
  resolution ? "1920x1080",
  symlinkJoin,
  wpsoffice-cn,
  xwayland,
}:
symlinkJoin {
  meta = wpsoffice-cn.meta // {
    description = "${wpsoffice-cn.meta.description or "WPS Office CN"} (wrapped in rootful Xwayland)";
    mainProgram = "wps";
  };
  name = "wpsoffice-cn-xwayland-${wpsoffice-cn.version or "wrapped"}";
  nativeBuildInputs = [ makeWrapper ];
  paths = [ wpsoffice-cn ];
  postBuild = ''
    # Minimal Openbox config: auto-maximize WPS without double titlebars
    mkdir -p $out/share/wps-openbox
    cat > $out/share/wps-openbox/rc.xml << 'EOF'
    <?xml version="1.0" encoding="UTF-8"?>
    <openbox_config xmlns="http://openbox.org">
      <applications>
        <application class="*">
          <decor>no</decor>
          <maximized>true</maximized>
        </application>
      </applications>
    </openbox_config>
    EOF

    # Rootful Xwayland runner script
    mkdir -p $out/libexec
    cat > $out/libexec/run-in-xwayland << 'EOF'
    #!@bash@/bin/bash
    set -e

    APP="$1"
    shift

    # Pick an unused X11 display starting at :20
    DISP=20
    while [ -e "/tmp/.X''${DISP}-lock" ]; do
      DISP=$((DISP + 1))
    done

    cleanup() {
      kill "$OB_PID" "$XW_PID" 2>/dev/null || true
    }
    trap cleanup EXIT INT TERM

    @xwayland@/bin/Xwayland ":$DISP" -ac -geometry @resolution@ >/dev/null 2>&1 &
    XW_PID=$!

    for _ in $(seq 1 50); do
      [ -S "/tmp/.X11-unix/X$DISP" ] && break
      sleep 0.05
    done

    DISPLAY=":$DISP" @openbox@/bin/openbox --config-file "@out@/share/wps-openbox/rc.xml" >/dev/null 2>&1 &
    OB_PID=$!

    DISPLAY=":$DISP" "$APP" "$@"
    EOF

    substituteInPlace $out/libexec/run-in-xwayland \
      --replace-fail "@out@" "$out" \
      --replace-fail "@bash@" "${bash}" \
      --replace-fail "@xwayland@" "${xwayland}" \
      --replace-fail "@openbox@" "${openbox}" \
      --replace-fail "@resolution@" "${resolution}"
    chmod +x $out/libexec/run-in-xwayland

    # Wrap wps, et, wpp, and wpspdf binaries
    for bin in wps et wpp wpspdf; do
      if [ -e "$out/bin/$bin" ]; then
        rm -f "$out/bin/$bin"
        makeWrapper "$out/libexec/run-in-xwayland" "$out/bin/$bin" \
          --add-flags "${wpsoffice-cn}/bin/$bin"
      fi
    done

    # Rewrite hardcoded store paths in .desktop files so app launchers use the wrapper
    if [ -d "$out/share/applications" ]; then
      rm -rf "$out/share/applications"
      mkdir -p "$out/share/applications"
      for f in ${wpsoffice-cn}/share/applications/*.desktop; do
        substitute "$f" "$out/share/applications/$(basename "$f")" \
          --replace-quiet "${wpsoffice-cn}/bin/" "$out/bin/"
      done
    fi
  '';
}
