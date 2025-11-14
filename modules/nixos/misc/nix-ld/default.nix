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
        glibc
      ]);
    };
  };
}
