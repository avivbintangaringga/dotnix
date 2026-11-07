{
  autoPatchelfHook,
  coreutils,
  dpkg,
  fetchurl,
  file,
  ghostscript,
  gnugrep,
  gnused,
  lib,
  makeWrapper,
  perl,
  stdenv,
  which,
}:

stdenv.mkDerivation {
  buildInputs = [ perl ];
  dontBuild = true;
  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/lib/cups/filter $out/share/cups/model
    cp -r opt $out/
    chmod -R u+w $out/opt
    d=$out/opt/brother/Printers/dcpt220

    rm -rf $d/lpd/i686

    ln -s x86_64/brdcpt220filter     $d/lpd/brdcpt220filter
    ln -s x86_64/brprintconf_dcpt220 $d/lpd/brprintconf_dcpt220
    ln -s $d/lpd/brprintconf_dcpt220 $out/bin/brprintconf_dcpt220

    w=$d/cupswrapper/brother_lpdwrapper_dcpt220
    patchShebangs $d

    substituteInPlace $w \
      --replace-fail '$basedir =~ s/$PRINTER\/cupswrapper\/.*$/$PRINTER\//g;' \
                     "\$basedir = \"$d/\";" \
      --replace-fail '$PRINTER =~ s/^\/opt\/.*\/Printers\///g;' \
                     '$PRINTER =~ s/^.*\/Printers\///g;' \
      --replace-fail 'cp  $basedir/inf/br' \
                     'cp --no-preserve=mode $basedir/inf/br' \
      --replace-fail '$CUPSINPUT=$ARGV[7];' \
                     '$CUPSINPUT=$ARGV[5];'

    substituteInPlace $d/lpd/filter_dcpt220 \
      --replace-fail /usr/bin/pdf2ps pdf2ps

    wrapProgram $w --prefix PATH : ${
      lib.makeBinPath [
        ghostscript
        file
        gnused
        gnugrep
        coreutils
        which
      ]
    }:$out/bin

    ln -s $w $out/lib/cups/filter/brother_lpdwrapper_dcpt220
    ln -s $d/cupswrapper/brother_dcpt220_printer_en.ppd $out/share/cups/model/

    runHook postInstall
  '';
  meta = {
    description = "Brother DCP-T220 CUPS driver";
    license = lib.licenses.unfree;
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
  nativeBuildInputs = [
    dpkg
    autoPatchelfHook
    makeWrapper
  ];
  pname = "dcpt220-driver";
  sourceRoot = ".";
  src = fetchurl {
    hash = "sha256-Yl8dCL8buDHLx8X5Iw2pkUGE/9zpy5c2/HjwBtVfNIw=";
    url = "https://download.brother.com/welcome/dlf105164/dcpt220pdrv-3.5.0-1.i386.deb";
  };
  unpackCmd = "dpkg-deb -x $src .";
  version = "3.5.0-1";
}
