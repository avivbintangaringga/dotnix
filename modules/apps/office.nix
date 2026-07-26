{
  den,
  ...
}:
{
  den.aspects.office = {
    includes = with den.aspects; [
      bluemail
    ];

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
