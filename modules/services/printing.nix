{
  dotnix.printing.nixos = { pkgs, ... }: {
    services = {
      printing = {
        enable = true;
        drivers = with pkgs; [
          canon-capt
          canon-cups-ufr2
          carps-cups
          cups-bjnp
          cnijfilter2
          gutenprint
          brgenml1lpr
          brgenml1cupswrapper
        ];
      };
      ipp-usb = {
        enable = true;
      };
    };
  };
}
