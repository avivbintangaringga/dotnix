{
  autoPatchelfHook,
  dpkg,
  fetchurl,
  glib-networking,
  gtk3,
  lib,
  librsvg,
  nodejs_24,
  stdenv,
  webkitgtk_4_1,
  wrapGAppsHook3,
}:
stdenv.mkDerivation (finalAttrs: {
  buildInputs = [
    webkitgtk_4_1
    gtk3
    glib-networking
    librsvg
    stdenv.cc.cc.lib
  ];
  dontStrip = true;
  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp -r usr/* $out/

    # foreign-arch binaries break autoPatchelfHook
    find $out -name '*linux-arm64*.node' -delete

    # the bundled node segfaults once patched, use nixpkgs' node instead
    rm $out/bin/libredb-studio-node
    ln -s ${lib.getExe nodejs_24} $out/bin/libredb-studio-node

    runHook postInstall
  '';
  meta = {
    description = "Open-source SQL IDE for cloud-native teams";
    homepage = "https://libredb.org";
    license = lib.licenses.mit;
    mainProgram = "libredb-studio-desktop";
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
    wrapGAppsHook3
  ];
  pname = "libredb-studio";
  src = fetchurl {
    hash = "sha256-VJegFzEh3qCD0ynATkSgF1JCkw7ctTDPYmCo19XeJNU=";
    url = "https://github.com/libredb/libredb-studio/releases/download/${finalAttrs.version}/libredb-studio-desktop_${finalAttrs.version}_amd64.deb";
  };
  unpackPhase = ''
    runHook preUnpack
    dpkg-deb -x $src .
    runHook postUnpack
  '';
  version = "1.1.0";
})
