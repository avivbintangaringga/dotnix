{
  lib,
  config,
  ...
}:
{
  options = {
    setup.misc.vmware.enable = lib.mkEnableOption "VMWare";
  };

  config = lib.mkIf config.setup.misc.vmware.enable {
    virtualisation = {
      vmware = {
        host.enable = true;
      };
    };
  };
}
