{
  self,
  ...
}:
{
  flake.modules.nixosModules.inferno = {
    imports = with self.modules.nixosModules; [
      r7fx
    ];

    systemd.tmpfiles.rules = [
      "f /dev/shm/scream 0660 r7fx qemu-libvirtd -"
      "f /dev/shm/looking-glass 0660 r7fx qemu-libvirtd -"
    ];
  };
}
