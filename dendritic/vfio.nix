{
  den.aspects.vfio = {
    nixos = { user, ... }: {
      systemd.tmpfiles.rules = [
        "f /dev/shm/scream 0660 ${user.userName} qemu-libvirtd -"
        "f /dev/shm/looking-glass 0660 ${user.userName} qemu-libvirtd -"
      ];
    };
  };
}
