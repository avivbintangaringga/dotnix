{
  dotnix.kvmfr.nixos =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      services.udev.packages = lib.singleton (
        pkgs.writeTextFile {
          destination = "/etc/udev/rules.d/70-kvmfr.rules";
          name = "kvmfr";
          text = ''
            SUBSYSTEM=="kvmfr", GROUP="kvm", MODE="0660", TAG+="uaccess"
          '';
        }
      );
      boot = {
        extraModprobeConfig = "options kvmfr static_size_mb=128";
        extraModulePackages = [
          config.boot.kernelPackages.kvmfr
        ];
        initrd.kernelModules = [ "kvmfr" ];
        kernelModules = [ "kvmfr" ];
        kernelParams = [ "kvmfr.static_size_mb=128" ];
      };
    };
}
