# Repackages the prebuilt Arch packages droidloom-{base,image,runtime} (no recompilation).
#
#   base    : Android system/system_ext/product EROFS images  -> pure data
#   image   : vendor image + Android-side (Bionic) binaries   -> must NOT be patched
#   runtime : host-side Rust binaries (glibc), units, polkit  -> autoPatchelf
#
# Usage: pkgs.callPackage ./package.nix { }
{
  autoPatchelfHook,
  fetchurl,
  lib,
  libgbm, # libgbm.so.1 (older nixpkgs: use `mesa` instead)
  libxkbcommon,
  linux-pam, # dlopen'd by droidloomd
  pipewire,
  stdenv,
  symlinkJoin,
  systemd,
  vulkan-loader, # dlopen'd by droidloom-gpu-server
  zstd,
}:

let
  version = "0.1.0";
  rel = "49";
  baseUrl = "https://github.com/denialwm/droidloom/releases/download/packages";

  fetchPart =
    part: hash:
    fetchurl {
      inherit hash;
      url = "${baseUrl}/droidloom-${part}-${version}-${rel}-x86_64.pkg.tar.zst";
    };

  # Extract the pacman tarball into $out, dropping pacman metadata and the usr/ prefix.
  unpack = ''
    mkdir -p "$out"
    tar --zstd --no-same-owner -xf "$src" -C "$out" \
      --exclude=.PKGINFO --exclude=.MTREE --exclude=.BUILDINFO --exclude=.INSTALL
    mv "$out"/usr/* "$out"/
    rmdir "$out"/usr
  '';

  common = {
    inherit version;
    dontBuild = true;
    dontConfigure = true;
    dontUnpack = true;
  };

  meta = {
    description = "Droidloom: Android applications in native Wayland windows (repackaged Arch binaries)";
    homepage = "https://github.com/denialwm/droidloom";
    license = with lib.licenses; [
      gpl3Plus
      asl20
      unfree
    ];
    mainProgram = "droidloomctl";
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };

  # --- pure data: skip the whole fixup phase (no strip, no patchShebangs, no patchelf) ---
  base = stdenv.mkDerivation (
    common
    // {
      inherit meta;
      dontFixup = true;
      installPhase = ''
        runHook preInstall
        ${unpack}
        runHook postInstall
      '';
      nativeBuildInputs = [ zstd ];
      pname = "droidloom-base";
      src = fetchPart "base" "sha256-qjE9By+JNcbFZzKnRAote6uOt5dUDjDgdBHKkblfcm4=";
    }
  );

  # --- Android-side binaries (linker64 / Bionic): never touch them ---
  image = stdenv.mkDerivation (
    common
    // {
      inherit meta;
      dontFixup = true; # also keeps patchShebangs away from the #!/system/bin/sh scripts
      installPhase = ''
        runHook preInstall
        ${unpack}
        runHook postInstall
      '';
      nativeBuildInputs = [ zstd ];
      pname = "droidloom-image";
      src = fetchPart "image" "sha256-ptzEnodycmKmskm9etDtFA0RSSULmD81HRUeW9r69p8=";
    }
  );

  # --- host binaries: the only place autoPatchelf runs ---
  runtime = stdenv.mkDerivation (
    common
    // {
      inherit meta;
      buildInputs = [
        stdenv.cc.cc.lib
        libgbm
        libxkbcommon
        pipewire
      ];
      installPhase = ''
        runHook preInstall
        ${unpack}
        runHook postInstall
      '';
      nativeBuildInputs = [
        zstd
        autoPatchelfHook
      ];
      pname = "droidloom-runtime";
      postInstall = ''
        # pacman hooks are meaningless on NixOS
        rm -r "$out/share/libalpm"

        # units: point at the store (binaries keep their own hardcoded /usr/bin paths,
        # the NixOS module provides those via tmpfiles)
        for f in "$out"/lib/systemd/system/*.service "$out"/lib/systemd/user/*.service; do
          substituteInPlace "$f" \
            --replace-quiet /usr/bin/systemctl ${systemd}/bin/systemctl \
            --replace-quiet /usr/bin/ "$out/bin/"
        done

        # pkexec resolves symlinks, so the polkit action must name the real store path
        substituteInPlace "$out/share/polkit-1/actions/org.droidloom.setup.policy" \
          --replace-fail /usr/lib/droidloom/droidloom-package-helper \
                         "$out/lib/droidloom/droidloom-package-helper"
      '';
      runtimeDependencies = [
        linux-pam
        vulkan-loader
      ];
      src = fetchPart "runtime" "sha256-pQow/GZPEoRVbRztUaOGRBqytMIXeuWBKFoOsAKkaEw=";
    }
  );
in
symlinkJoin {
  inherit meta;
  name = "droidloom-${version}-${rel}";
  passthru = { inherit base image runtime; };
  paths = [
    base
    image
    runtime
  ];
}
