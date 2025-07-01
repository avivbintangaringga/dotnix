{
  lib,
  config,
  pkgs,
  userdata,
  ...
}:
{
  options = {
    setup.misc.virt-manager.enable = lib.mkEnableOption "virt-manager";
  };

  config = lib.mkIf config.setup.misc.virt-manager.enable {
    environment.systemPackages = with pkgs; [
      virt-manager
      virt-viewer
      spice
      spice-gtk
      spice-protocol
      win-virtio
      win-spice
      adwaita-icon-theme
      virtiofsd
    ];

    virtualisation = {
      libvirtd = {
        enable = true;
        qemu = {
          package = pkgs.qemu_kvm;
          runAsRoot = true;
          swtpm.enable = true;
          ovmf = {
            enable = true;
            packages = [ pkgs.OVMFFull.fd ];
          };
          vhostUserPackages = with pkgs; [ virtiofsd ];
        };
      };
      spiceUSBRedirection.enable = true;
    };

    services = {
      spice-vdagentd.enable = true;
    };

    users.users.${userdata.username} = {
      extraGroups = [ "libvirtd" ];
    };
  };
}
