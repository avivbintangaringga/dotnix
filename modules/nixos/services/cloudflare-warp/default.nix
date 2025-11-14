{ lib, config, ... }:
{
  options = {
    setup.services.cloudflare-warp.enable = lib.mkEnableOption "Cloudflare Warp";
  };

  config = lib.mkIf config.setup.services.cloudflare-warp.enable {
    services = {
      cloudflare-warp = {
        enable = true;
      };
    };
  };
}
