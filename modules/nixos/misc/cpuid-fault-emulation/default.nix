{ config, lib, ... }:
{
  options = {
    setup.misc.cpuid-fault-emulation.enable = lib.mkEnableOption "CPUID Fault Emulation";
  };

  config = lib.mkIf config.setup.misc.cpuid-fault-emulation.enable {
    boot = {
      kernelModules = [ "cpuid_fault_emulation" ];

      extraModulePackages = [
        (config.boot.kernelPackages.callPackage ./package.nix {})
      ];

      extraModprobeConfig = ''
        options cpuid_fault_emulation ignore_svm_enabled=1
      '';
    };
  };
}
