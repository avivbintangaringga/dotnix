{
  autoPatchelfHook,
  dpkg,
  fetchurl,
  glib-networking,
  gtk3,
  lib,
  libayatana-appindicator,
  librsvg,
  mpv-unwrapped,
  stdenv,
  webkitgtk_4_1,
  wrapGAppsHook3,
}:
stdenv.mkDerivation (finalAttrs: {
  buildInputs = [
    webkitgtk_4_1
    gtk3
    mpv-unwrapped
    glib-networking
    librsvg
    stdenv.cc.cc.lib
  ];
  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp -r usr/* $out/

    substituteInPlace $out/share/applications/limusic.desktop \
      --replace-quiet "/usr/bin/" ""

    ln -s $out/bin/limusic-app $out/bin/limusic
    runHook postInstall
  '';
  meta = {
    description = "Desktop YouTube Music client";
    homepage = "https://github.com/SimoHypers/limusic";
    mainProgram = "limusic-app";
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
    wrapGAppsHook3
  ];
  pname = "limusic";
  runtimeDependencies = [ libayatana-appindicator ];
  src = fetchurl {
    hash = "sha256-9DQOaV3IyrFuUMjSqctknjALRUzJGitnrG8u/xOXPzk=";
    url = "https://github.com/SimoHypers/limusic/releases/download/v${finalAttrs.version}/limusic_${finalAttrs.version}_amd64.deb";
  };
  unpackPhase = ''
    runHook preUnpack
    dpkg-deb -x $src .
    runHook postUnpack
  '';
  version = "1.1.0";
})
