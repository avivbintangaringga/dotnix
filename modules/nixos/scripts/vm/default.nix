{ pkgs, ... }:
{
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
      
      notify-send "Starting vm: $VM..." -i ${../../../../assets/icons/vm.png}
      virsh -c qemu:///system start $VM

      notify-send "Starting Looking Glass Client..." -i ${../../../../assets/icons/lg.png}
      lg
    '')
  ];
}
