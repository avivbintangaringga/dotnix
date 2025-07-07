{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "nv-switch" ''
      USE_PKEXEC=false

      if [[ $2 == "pkexec" ]]
      then
        USE_PKEXEC=true
      fi
      
      notify() {
        notify-send "$1"
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

        echo "Switching to host mode..."
        notify "Switching to host mode..."

        if $USE_PKEXEC
        then
          pkexec exec_nvswitch_to_host
        else
          sudo exec_nvswitch_to_host
        fi

        echo "Done"
        notify "Switched to host mode"
      }

      switch_to_vm() {
        mode_is_not_or_exit "vm"

        echo "Switching to vm mode..."
        notify "Switching to vm mode..."

        if $USE_PKEXEC
        then
          pkexec exec_nvswitch_to_vm
        else
          sudo exec_nvswitch_to_vm
        fi

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

    (pkgs.writeShellScriptBin "exec_nvswitch_to_host" ''
      virsh nodedev-reattach pci_0000_01_00_0
      rmmod vfio_pci vfio_pci_core vfio_iommu_type1
      modprobe -i nvidia
      modprobe -i nvidia_uvm
      modprobe -i nvidia_modeset
      systemctl restart nvidia-powerd
    '')

    (pkgs.writeShellScriptBin "exec_nvswitch_to_vm" ''
      systemctl stop nvidia-powerd
      rmmod nvidia_uvm
      rmmod nvidia_modeset
      rmmod nvidia
      modprobe -i vfio_pci vfio_pci_core vfio_iommu_type1
      virsh nodedev-detach pci_0000_01_00_0
    '')
  ];
}
