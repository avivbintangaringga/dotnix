{
  dotnix.cpuid-fault-emulation = {
    nixos = { config, ... }: {
      boot = {
        kernelModules = [ "cpuid_fault_emulation" ];
        kernelParams = [ "clearcpuid=umip" ];

        extraModulePackages = [
          (config.boot.kernelPackages.callPackage ./_package/package.nix {})
        ];

        extraModprobeConfig = ''
          options cpuid_fault_emulation ignore_svm_enabled=1
        '';
      };
    };
  };
}
