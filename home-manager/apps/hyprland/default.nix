{ lib, pkgs, userdata, ... }@args:
{
   wayland.windowManager.hyprland = {
     enable = true;
     xwayland.enable = true;

     settings = lib.mkMerge [
       (import ./vars.nix args)
       (import ./env.nix)
       (import ./general.nix)
       (import ./binds.nix)
       (import ./input.nix)

       {
         monitor = ",1920x1080@144,auto,1";
       }
     ];
   };
}
