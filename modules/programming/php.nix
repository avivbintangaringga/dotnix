{
  dotnix.php.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [
      phpactor
      php82
      php82Packages.composer
    ];
  };
}
