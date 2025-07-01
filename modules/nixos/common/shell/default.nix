{ pkgs, userdata, ... }:
{
  programs.zsh = {
    enable = true;
    shellAliases = {
      edit = "hx /home/${userdata.username}/dotnix";
      update = "nh os switch /home/${userdata.username}/dotnix --no-nom";
      hm-update = "nh home switch /home/${userdata.username}/dotnix --no-nom -b hm-bak";
      upgrade = ''
        cd /home/${userdata.username}/dotnix &&
        git add . &&
        git commit -m "before upgrade" &&
        git push &&
        nix flake update &&
        update &&
        hm-update &&
        git commit -am "after upgrade" &&
        git push &&
        echo "DONE!"
      '';
      nvidia-host = ''
        sudo virsh nodedev-reattach pci_0000_01_00_0
        sudo rmmod vfio_pci vfio_pci_core vfio_iommu_type1
        sudo modprobe -i nvidia
        sudo modprobe -i nvidia_uvm
        sudo modprobe -i nvidia_modeset
        sudo systemctl restart nvidia-powerd
      '';
      nvidia-vm = ''
        sudo systemctl stop nvidia-powerd
        sudo rmmod nvidia_uvm
        sudo rmmod nvidia_modeset
        sudo rmmod nvidia
        sudo modprobe -i vfio_pci vfio_pci_core vfio_iommu_type1
        sudo virsh nodedev-detach pci_0000_01_00_0
      '';
      nvidia-status = ''
        if lspci -nnk | grep -i nvidia -A 3 | grep -q vfio; then echo "VM Mode"; else echo "Host Mode"; fi
      '';
      win11 = "virsh -c qemu:///system start win11 && looking-glass-client -F audio:micDefault=allow audio:micSHowIndicator=no audio:periodSize=512";
    };
  };

  programs.starship = {
    enable = true;
  };

  users.users.${userdata.username} = {
    shell = pkgs.zsh;
  };

  environment.shells = with pkgs; [
    zsh
  ];
}
