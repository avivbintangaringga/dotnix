{
  inputs,
  ...
}:
{
  dotnix.guesthouse.nixos = { user, ... }: {
    imports = [
      inputs.guesthouse.nixosModules.default
    ];

    programs.guesthouse.enable = true;
    services.udev.extraRules = ''
      SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", MODE="0660", GROUP="guesthouse"
    '';
    users.groups.guesthouse = {};
    users.users.${user.userName}.extraGroups = [ "guesthouse" ];
  };
  flake-file.inputs.guesthouse = {
    inputs.nixpkgs.follows = "nixpkgs";
    url = "github:xnixy/guesthouse/test-app-windows-2";
  };
}
