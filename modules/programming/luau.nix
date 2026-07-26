{
  dotnix.luau = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs;[
        luau
        luau-lsp
        stylua
      ];
    };
  };
}
