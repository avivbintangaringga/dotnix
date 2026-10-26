{
  autoPatchelfHook,
  fetchurl,
  lib,
  stdenv,
}:
stdenv.mkDerivation (finalAttrs: {
  buildInputs = [
    stdenv.cc.cc.lib
  ];
  installPhase = ''
    runHook preInstall
    install -Dm755 ai-usagebar $out/bin/ai-usagebar
    install -Dm755 ai-usagebar-tui $out/bin/ai-usagebar-tui
    install -Dm644 config.example.toml $out/share/ai-usagebar/config.example.toml
    install -Dm644 README.md $out/share/doc/ai-usagebar/README.md
    runHook postInstall
  '';
  meta = {
    description = "AI usage bar and TUI";
    homepage = "https://github.com/akitaonrails/ai-usagebar";
    license = lib.licenses.mit;
    mainProgram = "ai-usagebar";
    platforms = [ "x86_64-linux" ];
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  };
  nativeBuildInputs = [
    autoPatchelfHook
  ];
  pname = "ai-usagebar";
  sourceRoot = ".";
  src = fetchurl {
    hash = "sha256-H0vOTmcJguSTtQZbwdPi3KrJN6lzbKj6aKIae/OPZGo=";
    url = "https://github.com/akitaonrails/ai-usagebar/releases/download/v${finalAttrs.version}/ai-usagebar-linux-x86_64.tar.gz";
  };
  version = "1.44.0";
})
