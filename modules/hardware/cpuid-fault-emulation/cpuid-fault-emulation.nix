{
  dotnix.cpuid-fault-emulation.nixos = { config, ... }: {
    boot = {
      extraModprobeConfig = ''
        options cpuid_fault_emulation ignore_svm_enabled=1
      '';
      extraModulePackages = [
        (config.boot.kernelPackages.callPackage ./_package/package.nix { })
      ];
      kernelModules = [ "cpuid_fault_emulation" ];
      kernelParams = [ "clearcpuid=umip" ];
    };
  };
}
