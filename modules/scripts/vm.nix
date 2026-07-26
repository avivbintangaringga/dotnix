{
  flake-root,
  ...
}:
{
  den.aspects.scripts.vm = {
    nixos = { pkgs, ... }: {
      environment.systemPackages = [
        (pkgs.writeShellScriptBin "lg" ''
          looking-glass-client -F audio:micDefault=allow audio:micSHowIndicator=no audio:periodSize=512
        '')

        (pkgs.writeShellScriptBin "vm-start" ''
          if [[ -z $1 ]]
          then
            echo "VM Name is required!"
            exit 1
          fi

          VM=$1

          notify-send "Starting vm: $VM..." -i ${flake-root + "/assets/icons/vm.png"}
          virsh -c qemu:///system start $VM

          notify-send "Starting Looking Glass Client..." -i ${flake-root + "/assets/icons/lg.png"}
          lg
        '')

        (pkgs.writeShellScriptBin "vm_waybar_hook" ''
          ACTION=$1

          get() {
            VM_LIST=$(virsh -c qemu:///system list --state-running --name | awk NF)
            RUNNING_VM_COUNT=$(echo -n "$VM_LIST" | grep "" -c)
            FIRST_RUNNING_VM=$(echo -n "$VM_LIST" | head -1)

            if [[ $RUNNING_VM_COUNT -ge 1 ]]
            then
              if [[ $RUNNING_VM_COUNT -eq 1 ]]
              then
                echo "  |  $FIRST_RUNNING_VM"
              else
                echo "  |  $RUNNING_VM_COUNT VMs"
              fi
            fi
          }

          click() {
            RUNNING_VM_COUNT=$(virsh -c qemu:///system list --state-running --name | awk NF | grep "" -c)

            if [[ $RUNNING_VM_COUNT -ge 1 ]]
            then
              if [[ $RUNNING_VM_COUNT -eq 1 ]]
              then
                lg
              else
                virt-manager
              fi
            fi
          }

          case $ACTION in
            "get")
              get
                ;;
            "click")
              click
                ;;
            *)
              echo "Unknown action!"
              exit 1
                ;;
          esac
        '')
      ];
    };
  };
}
