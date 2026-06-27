{ lib, config, pkgs, ... }:
{
  options = {
    setup.services.printing.enable = lib.mkEnableOption "Printer";
  };

  config = lib.mkIf config.setup.services.printing.enable {
    services = {
      printing = {
        enable = true;
	      drivers = with pkgs; [
	        canon-capt
	        canon-cups-ufr2
	        carps-cups
	        cups-bjnp
	        cnijfilter2
	      ];
      };
    };
  };
}
