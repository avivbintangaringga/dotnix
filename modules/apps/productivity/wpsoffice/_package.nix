{
  clipboardBridge ? true,
  clipnotify,
  coreutils,
  gnugrep,
  imagemagick,
  lib,
  makeWrapper,
  openbox,
  picom,
  resolution ? "1920x1080",
  symlinkJoin,
  util-linux,
  wl-clipboard,
  wpsoffice-cn,
  writeShellApplication,
  writeText,
  xclip,
  xwayland,
}:

let
  openboxConfig = writeText "wps-openbox-rc.xml" ''
    <?xml version="1.0" encoding="UTF-8"?>
    <openbox_config xmlns="http://openbox.org/3.4/rc">
      <applications>
        <!-- only main windows: dialogs/splash keep normal size and placement -->
        <application class="*" type="normal">
          <decor>no</decor>
          <maximized>yes</maximized>
        </application>
      </applications>
    </openbox_config>
  '';

  # Fallback Wayland <-> X11 clipboard bridge. Modes: w2x | x2w
  bridge = writeShellApplication {
    name = "wps-clip-bridge";
    runtimeInputs = [
      coreutils
      gnugrep
      util-linux
      wl-clipboard
      xclip
      clipnotify
      imagemagick
    ];
    text = ''
      mode=$1
      disp=$2
      state=$3

      export DISPLAY=":$disp"
      umask 077
      mkdir -p "$state"
      max_bytes=$((32 * 1024 * 1024))
      tmp=""
      raw=""
      trap 'rm -f "$tmp" "$raw"' EXIT

      exec 7>"$state/lock"

      too_big() { [ "$(stat -c %s "$1")" -gt "$max_bytes" ]; }

      # claim FILE MINE THEIRS: succeed only if FILE is non-empty and is not
      # what the other direction delivered last (i.e. not an echo of ourselves).
      claim() {
        [ -s "$1" ] || return 1
        local h
        h=$(sha256sum <"$1" | cut -d' ' -f1)
        if [ -f "$state/$3.hash" ] && [ "$(cat "$state/$3.hash")" = "$h" ]; then
          return 1
        fi
        printf '%s' "$h" >"$state/$2.hash"
      }

      w2x() {
        local types t fmt xt
        types=$(timeout 5 wl-paste --list-types 2>/dev/null || true)
        [ -n "$types" ] || return 0
        # never mirror password-manager secrets
        if printf '%s\n' "$types" | grep -qix 'x-kde-passwordManagerHint'; then return 0; fi

        tmp=$(mktemp "$state/w2x.XXXXXX")
        raw=$(mktemp "$state/raw.XXXXXX")

        if printf '%s\n' "$types" | grep -qx 'image/png'; then
          xt=image/png
          timeout 10 wl-paste --type image/png 2>/dev/null | head -c "$((max_bytes + 1))" >"$tmp" || true
        elif t=$(printf '%s\n' "$types" | grep -m1 -xE 'image/(jpeg|webp|bmp)'); then
          xt=image/png
          fmt=$(printf '%s' "$t" | cut -d/ -f2)
          timeout 10 wl-paste --type "$t" 2>/dev/null | head -c "$((max_bytes + 1))" >"$raw" || true
          too_big "$raw" && return 0
          # explicit input format (no sniffing) + resource limits
          timeout 30 magick -limit memory 512MiB -limit map 512MiB -limit disk 1GiB -limit time 30 \
            "$fmt:-" png:- <"$raw" >"$tmp" 2>/dev/null || true
        elif printf '%s\n' "$types" | grep -qx 'text/html'; then
          xt=text/html
          timeout 10 wl-paste --type text/html 2>/dev/null | head -c "$((max_bytes + 1))" >"$tmp" || true
        elif t=$(printf '%s\n' "$types" | grep -m1 -xE 'text/plain;charset=utf-8|text/plain|UTF8_STRING|STRING'); then
          xt=UTF8_STRING
          timeout 10 wl-paste --no-newline --type "$t" 2>/dev/null | head -c "$((max_bytes + 1))" >"$tmp" || true
        else
          return 0
        fi

        too_big "$tmp" && return 0
        flock 7
        claim "$tmp" w2x x2w || return 0
        # 7>&- : xclip daemonizes; it must not inherit (and hold) our lock
        xclip -selection clipboard -t "$xt" -in <"$tmp" 7>&-
      }

      x2w_once() {
        local targets xt wt
        targets=$(timeout 5 xclip -selection clipboard -o -t TARGETS 2>/dev/null || true)
        wt=""
        if printf '%s\n' "$targets" | grep -qx 'image/png'; then
          xt=image/png
          wt=image/png
        elif xt=$(printf '%s\n' "$targets" | grep -m1 -xE 'UTF8_STRING|text/plain;charset=utf-8'); then
          :
        else
          return 0
        fi

        tmp=$(mktemp "$state/x2w.XXXXXX")
        timeout 10 xclip -selection clipboard -o -t "$xt" 2>/dev/null | head -c "$((max_bytes + 1))" >"$tmp" || true
        if ! too_big "$tmp"; then
          flock 7
          if claim "$tmp" x2w w2x; then
            if [ -n "$wt" ]; then
              wl-copy --type "$wt" <"$tmp" 7>&- || true
            else
              wl-copy <"$tmp" 7>&- || true
            fi
          fi
          flock -u 7
        fi
        rm -f "$tmp"
      }

      case "$mode" in
        w2x) w2x ;;
        # clipnotify blocks until the X clipboard owner changes; it exits when X goes away
        # (verify your clipnotify supports "-s clipboard": clipnotify -h)
        x2w) while clipnotify -s clipboard; do x2w_once; done ;;
        *) echo "usage: wps-clip-bridge w2x|x2w DISP STATE" >&2; exit 2 ;;
      esac
    '';
  };

  # Long-lived supervisor: Xwayland + openbox + picom + bridge. Exits when the last client is gone.
  session = writeShellApplication {
    name = "wps-xwayland-session";
    runtimeInputs = [
      coreutils
      util-linux
      xwayland
      openbox
      picom
      wl-clipboard
    ];
    text = ''
      base=$1
      state="$base/state"
      umask 077
      mkdir -p "$state"
      exec 8>"$base/clients.lock"

      cleanup() {
        trap - EXIT
        rm -f "$base/display" "$base/display.tmp" "$base/displayfd"
        # shellcheck disable=SC2046
        kill $(jobs -p) 2>/dev/null || true
        rm -rf "$state"
      }
      trap cleanup EXIT
      trap 'exit 143' INT TERM

      # no -ac, no TCP; Xwayland picks a free display number itself
      # (recent Xwayland is rootful by default, so no -rootful flag)
      Xwayland -nolisten tcp -geometry "${resolution}" -displayfd 3 3>"$base/displayfd" &
      xw=$!

      disp=""
      for _ in $(seq 1 100); do
        kill -0 "$xw" 2>/dev/null || { echo "Xwayland exited during startup" >&2; exit 1; }
        if [ -s "$base/displayfd" ]; then disp=$(head -n1 "$base/displayfd"); break; fi
        sleep 0.1
      done
      [ -n "$disp" ] || { echo "timed out waiting for Xwayland" >&2; exit 1; }

      export DISPLAY=":$disp"
      openbox --config-file ${openboxConfig} >/dev/null 2>&1 &

      # Compositing manager: gives Qt ARGB windows (rounded corners, translucent popups).
      # xrender backend needs no GL; /dev/null config so picom ignores the user's
      # ~/.config/picom/picom.conf and adds no shadows of its own.
      # -b forks only after picom has registered as the compositor, so this returns
      # as soon as it is ready (no fixed sleep) and Qt sees compositing from the start.
      picom -b --backend xrender --config /dev/null >/dev/null 2>&1 || true

      ${lib.optionalString clipboardBridge ''
        # initial sync in the background so it can't delay WPS startup
        ${lib.getExe bridge} w2x "$disp" "$state" &
        wl-paste --watch ${lib.getExe bridge} w2x "$disp" "$state" >/dev/null 2>&1 &
        ${lib.getExe bridge} x2w "$disp" "$state" &
      ''}

      printf '%s %s\n' "$disp" "$$" >"$base/display.tmp"
      mv "$base/display.tmp" "$base/display"

      # Exclusive lock is only grantable once every client (shared lock) has gone.
      flock -x 8 &
      lockpid=$!
      wait -n "$xw" "$lockpid" || true
    '';
  };

  # Per-invocation launcher: join or start the session, then exec the app.
  run = writeShellApplication {
    name = "wps-xwayland-run";
    runtimeInputs = [
      coreutils
      util-linux
    ];
    text = ''
      die() { echo "wps-xwayland: $*" >&2; exit 1; }

      app=$1
      shift

      [ -n "''${WAYLAND_DISPLAY:-}" ] || die "WAYLAND_DISPLAY is not set"
      [ -n "''${XDG_RUNTIME_DIR:-}" ] || die "XDG_RUNTIME_DIR is not set"

      umask 077
      base="$XDG_RUNTIME_DIR/wps-xwayland"
      mkdir -p "$base"

      exec 9>"$base/start.lock"
      flock -x 9
      exec 8>"$base/clients.lock"   # inherited by WPS => session lives while WPS (or helpers) live

      joined=0
      started=0
      for _ in $(seq 1 150); do
        disp=""
        spid=""
        { read -r disp spid <"$base/display"; } 2>/dev/null || true
        if [ -n "$spid" ] && kill -0 "$spid" 2>/dev/null && [ -S "/tmp/.X11-unix/X$disp" ]; then
          if flock -sn 8; then joined=1; break; fi
        else
          rm -f "$base/display"
          if flock -sn 8; then
            setsid ${lib.getExe session} "$base" 8>&- 9>&- >"$base/session.log" 2>&1 &
            joined=1
            started=1
            break
          fi
        fi
        sleep 0.1
      done
      [ "$joined" = 1 ] || die "could not join or start the Xwayland session"

      if [ "$started" = 1 ]; then
        for _ in $(seq 1 150); do
          [ -s "$base/display" ] && break
          sleep 0.1
        done
      fi

      disp=""
      spid=""
      { read -r disp spid <"$base/display"; } 2>/dev/null || true
      if [ -z "$disp" ]; then
        tail -n 20 "$base/session.log" >&2 || true
        die "Xwayland did not start (log: $base/session.log)"
      fi

      exec 9>&-
      export DISPLAY=":$disp"
      export QT_QPA_PLATFORM=xcb
      export GDK_BACKEND=x11
      exec "$app" "$@"
    '';
  };
in
symlinkJoin {
  meta = wpsoffice-cn.meta // {
    description = "${
      wpsoffice-cn.meta.description or "WPS Office CN"
    } (rootful Xwayland session, Wayland clipboard sync)";
    mainProgram = "wps";
  };
  name = "wpsoffice-cn-xwayland-${wpsoffice-cn.version or "wrapped"}";
  nativeBuildInputs = [ makeWrapper ];
  passthru.unwrapped = wpsoffice-cn;
  paths = [ wpsoffice-cn ];
  postBuild = ''
    for bin in wps et wpp wpspdf; do
      if [ -e "$out/bin/$bin" ]; then
        rm -f "$out/bin/$bin"
        makeWrapper ${lib.getExe run} "$out/bin/$bin" \
          --add-flags "${wpsoffice-cn}/bin/$bin"
      fi
    done

    # Point .desktop entries at the wrappers
    if [ -d "$out/share/applications" ]; then
      rm -rf "$out/share/applications"
      mkdir -p "$out/share/applications"
      for f in ${wpsoffice-cn}/share/applications/*.desktop; do
        substitute "$f" "$out/share/applications/$(basename "$f")" \
          --replace-warn "${wpsoffice-cn}/bin/" "$out/bin/"
      done
    fi
  '';
}
