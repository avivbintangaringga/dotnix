{
  alsa-lib,
  atk,
  autoPatchelfHook,
  cairo,
  copyDesktopItems,
  dpkg,
  fetchurl,
  fontconfig,
  freetype,
  gdk-pixbuf,
  glib,
  gtk3,
  lib,
  libGL,
  libx11,
  libxext,
  libxi,
  libxrender,
  libxtst,
  libxxf86vm,
  makeDesktopItem,
  makeWrapper,
  pango,
  stdenv,
  zlib,
}:
let
  runtimeLibs = [
    alsa-lib
    atk
    cairo
    fontconfig
    freetype
    gdk-pixbuf
    glib
    gtk3
    libGL
    pango
    libx11
    libxext
    libxi
    libxrender
    libxtst
    libxxf86vm
  ];
in
stdenv.mkDerivation rec {
  buildInputs = runtimeLibs ++ [
    stdenv.cc.cc.lib
    zlib
  ];
  desktopItems = [
    (makeDesktopItem {
      categories = [
        "Audio"
        "AudioVideo"
      ];
      comment = "Aesthetic YouTube Music client";
      desktopName = "BitChord";
      exec = "bitchord";
      icon = "bitchord";
      name = "bitchord";
    })
  ];
  dontBuild = true;
  dontConfigure = true;
  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib $out/bin
    cp -r opt/bitchord $out/lib/bitchord

    makeWrapper $out/lib/bitchord/bin/BitChord $out/bin/bitchord \
      --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath runtimeLibs}

    install -Dm644 opt/bitchord/lib/BitChord.png \
      $out/share/icons/hicolor/256x256/apps/bitchord.png

    runHook postInstall
  '';
  meta = {
    description = "Aesthetic YouTube Music client";
    homepage = "https://github.com/kushagrasinghx/BitChord";
    mainProgram = "bitchord";
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
    makeWrapper
    copyDesktopItems
  ];
  pname = "bitchord";
  src = fetchurl {
    hash = "sha256-taxbVoAVcgraR/N4Jj6Dx91tgjLZX8Jt3rS9FlHbGlQ=";
    url = "https://github.com/kushagrasinghx/BitChord/releases/download/v${version}/BitChord-${version}-linux-amd64.deb";
  };
  unpackPhase = ''
    runHook preUnpack
    dpkg-deb -x $src .
    runHook postUnpack
  '';
  version = "1.8";
}
