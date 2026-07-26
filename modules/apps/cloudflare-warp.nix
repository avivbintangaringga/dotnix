{
  dotnix.cloudflare-warp = {
    nixos = {
      services = {
        cloudflare-warp.enable = true;
      };
    };
  };
}
