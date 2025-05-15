{ lib, pkgs, userdata, ... }@args:
{
   wayland.windowManager.hyprland = {
     enable = true;
     xwayland.enable = true;

     settings = lib.mkMerge [
       {
         monitor = ",1920x1080@144,auto,1";
	 source = "~/.cache/hellwal/hyprland-colors.conf";
       }
       (import ./vars.nix args)
       (import ./env.nix)
       (import ./exec.nix)
       (import ./general.nix)
       (import ./layout.nix)
       (import ./decoration.nix)
       (import ./binds.nix)
       (import ./input.nix)
       (import ./misc.nix)
       (import ./rules.nix)
     ];
   };
}
