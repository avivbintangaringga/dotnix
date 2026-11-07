{
  dotnix.printing.nixos = { pkgs, ... }: {
    services = {
      ipp-usb = {
        enable = true;
      };
      printing = {
        drivers = with pkgs; [
          canon-capt
          canon-cups-ufr2
          carps-cups
          cups-bjnp
          cnijfilter2
          gutenprint
          brgenml1lpr
          brgenml1cupswrapper
          (pkgs.callPackage ./_printer-drivers/dcpt220.nix { })
        ];
        enable = true;
      };
    };

    systemd.tmpfiles.rules = [
      "L+ /opt/brother - - - - ${pkgs.callPackage ./_printer-drivers/dcpt220.nix { }}/opt/brother"
    ];
  };
}
