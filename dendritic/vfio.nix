{
  den.aspects.vfio = { user }: {
    nixos = {
      # TODO: change r7fx to dynamic
      systemd.tmpfiles.rules = [
        "f /dev/shm/scream 0660 ${user.userName} qemu-libvirtd -"
        "f /dev/shm/looking-glass 0660 ${user.userName} qemu-libvirtd -"
      ];
    };
  };
}
