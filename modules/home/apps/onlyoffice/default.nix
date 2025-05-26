{
  lib,
  config,
  options,
  ...
}:
{
  options = {
    setup.apps.onlyoffice.enable = lib.mkEnableOption "OnlyOffice";
  };

  config = lib.mkIf config.setup.apps.onlyoffice.enable {
    programs.onlyoffice = {
      enable = true;
    };
  };
}
