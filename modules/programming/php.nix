{
  dotnix.php.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [
      phpactor
      php85
      php85Packages.composer
    ];
  };
}
