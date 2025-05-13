{ lib, pkgs, userdata, ... }@args:
{
   wayland.windowManager.hyprland = {
     enable = true;
     xwayland.enable = true;

     settings = lib.mkMerge [
       {
         monitor = ",1920x1080@144,auto,1";
         
	 binds = {
           allow_workspace_cycles = true;
	   hide_special_on_workspace_change = true;
	 };
       }
       (import ./vars.nix args)
       (import ./env.nix)
       (import ./general.nix)
       (import ./decoration.nix)
       (import ./binds.nix)
       (import ./input.nix)
       (import ./misc.nix)
     ];
   };
}
