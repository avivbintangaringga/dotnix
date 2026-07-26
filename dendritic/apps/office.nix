{
  den.aspects.office = {
    homeManager = { pkgs, ... }: {
      home = {
        sessionVariables = {
          SAL_USE_VCLPLUGIN = "kf6";
        };

        packages = with pkgs; [
          libreoffice-qt6-fresh
        ];
      };

      programs.onlyoffice = {
        enable = true;
      };
    };
  };
}
