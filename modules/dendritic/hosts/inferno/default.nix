{
  inputs,
  config,
  ...
}:
let
  inherit (inputs.nixpkgs) lib;
  inherit (lib) nixosSystem;
in
{
  flake.nixosConfigurations.inferno = nixosSystem {
    modules = [
      inputs.self.modules.nixosModules.inferno
      inputs.hardware.nixosModules.asus-fa506ic
    ];
  };

  flake.modules.nixosModules.inferno =
    { pkgs, ... }:
    {
      imports = with inputs.self.modules.nixosModules; [
        base
      ];

      boot = {
        kernelPackages = pkgs.linuxPackages_zen;

        loader = {
          systemd-boot = {
            enable = true;
          };
          efi = {
            canTouchEfiVariables = true;
          };
          timeout = 1;
        };

        initrd = {
          availableKernelModules = [
            "nvme"
            "xhci_pci"
            "usb_storage"
            "sd_mod"
          ];
          kernelModules = [
            "snd-seq"
            "nvidia"
            "nvidia_modeset"
            "nvidia_drm"
            "nvidia_uvm"
          ];
        };

        kernelModules = [ "kvm-amd" ];
        extraModulePackages = [ ];
        kernelParams = [
          "amd_iommu=on"
          "iommu=pt"
          "vfio-pci.ids=10de:25a2,10de:2291"
        ];
      };

      networking = {
        hostName = "inferno";
      };

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

      system.stateVersion = "24.11";
    };
}
