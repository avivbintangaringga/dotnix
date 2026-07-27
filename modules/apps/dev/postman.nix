{
  dotnix.postman.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [
      postman
    ];
  };
}
