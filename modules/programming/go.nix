{
  dotnix.go.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [
      air
      gcc
      go-jet
      goose
      gopls
      templ
    ];
    programs.go.enable = true;
  };
}
