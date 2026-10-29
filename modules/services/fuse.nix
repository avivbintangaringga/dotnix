{
  dotnix.fuse.nixos = {
    programs.fuse = {
      enable = true;
      userAllowOther = true;
    };
  };
}
