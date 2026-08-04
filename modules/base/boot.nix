{
  dotnix.boot.nixos.boot = {
    kernel.sysctl = {
      "vm.nr_hugepages" = 0;
      "vm.swappiness" = 10;
      "vm.vfs_cache_pressure" = 200;
    };
    kernelParams = [
      "transparent_hugepage=madvise"
    ];
    supportedFilesystems = [ "ntfs" ];
  };
}
