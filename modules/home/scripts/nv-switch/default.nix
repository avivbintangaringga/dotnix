{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "testscript" ''
      echo "this is a test"
    '')
  ];
}
