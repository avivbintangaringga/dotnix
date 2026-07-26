{
  dotnix.lsp = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        tailwindcss-language-server
        taplo
        bash-language-server
        docker-compose-language-service
        vue-language-server
        yaml-language-server
      ];
    };
  };
}
