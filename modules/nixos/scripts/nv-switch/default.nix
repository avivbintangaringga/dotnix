{ pkgs, userdata, ... }:
{
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "nv-switch" ''
      QUIET=false

      # Just for quickness sake lol
      if [[ "$2" == "quiet" ]]
      then
        QUIET=true
      fi
      
      notify() {
        [[ $QUIET == false ]] && notify-send "$1" -i ${../../../../assets/icons/gpu.png}
      }

      check_current_mode() {
        if lspci -nnk | grep -i nvidia -A 3 | grep -qi vfio
        then
          echo "vm"
        else
          echo "host"
        fi
      }

      waybar() {
        if [[ $(check_current_mode) == "vm" ]]
        then
          echo "󰆧   VM Mode"
        else
          echo "󰍹   Host Mode"
        fi
      }

      mode_is_not_or_exit() {
        if [[ $(check_current_mode) == "$1" ]]
        then
          echo "Current mode is already $1 mode."
          exit 1

        fi
      }

      switch_to_host() {
        mode_is_not_or_exit "host"

        RUNNING_VM_COUNT=$(virsh -c qemu:///system list --state-running --name | awk NF | grep "" -c)

        if [[ $RUNNING_VM_COUNT -gt 0 ]]
        then
          echo "Cannot switch to host mode while there is running VM"
          notify "Cannot switch to host mode while there is running VM"
          exit 1
        fi

        echo "Switching to host mode..."
        notify "Switching to host mode..."

        sudo virsh nodedev-reattach pci_0000_01_00_0
        sudo rmmod vfio_pci vfio_pci_core vfio_iommu_type1
        sudo modprobe -i nvidia
        sudo modprobe -i nvidia_uvm
        sudo modprobe -i nvidia_modeset
        sudo modprobe -i nvidia_drm
        sudo systemctl restart nvidia-powerd

        echo "Done"
        notify "Switched to host mode"
      }

      switch_to_vm() {
        mode_is_not_or_exit "vm"

        USING_NVIDIA_COUNT=$(lsof /dev/nvidia0 | grep "" -c)
        if [[ $USING_NVIDIA_COUNT -gt 0 ]]
        then
          echo "Cannot switch to VM mode while the GPU is in use"
          notify "Cannot switch to VM mode while the GPU is in use"
          exit 1
        fi

        echo "Switching to vm mode..."
        notify "Switching to vm mode..."

        sudo systemctl --user --machine=${userdata.username}@ stop swaync # TEMPORARY FIX
        sudo systemctl stop nvidia-powerd
        sudo rmmod -f nvidia_drm
        sudo rmmod nvidia_uvm
        sudo rmmod nvidia_modeset
        sudo rmmod nvidia
        sudo modprobe -i vfio_pci vfio_pci_core vfio_iommu_type1
        sudo virsh nodedev-detach pci_0000_01_00_0
        sudo systemctl --user --machine=${userdata.username}@ start swaync # TEMPORARY FIX

        echo "Done"
        notify "Switched to vm mode"
        }

      toggle() {
        if [[ $(check_current_mode) == "host" ]]
        then
          switch_to_vm
        else
          switch_to_host
        fi
      }

      case $1 in
        "host")
          switch_to_host
          ;;
        "vm")
          switch_to_vm
          ;;
        "toggle")
          toggle
          ;;
        "get")
          check_current_mode
          ;;
        "waybar")
          waybar
          ;;
        *)
          echo "ERROR: Invalid argument!"
          exit 1
          ;;
      esac
    '')
  ];
}
