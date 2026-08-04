{
  dotnix.zram.nixos.zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
  };
}
