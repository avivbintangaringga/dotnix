{
  dotnix,
  ...
}:
{
  dotnix.office = {
    includes = with dotnix; [
      bluemail
    ];

    homeManager = { pkgs, ... }: {
      home = {
        packages = with pkgs; [
          libreoffice-qt6-fresh
        ];
        sessionVariables.SAL_USE_VCLPLUGIN = "kf6";
      };

      programs.onlyoffice.enable = true;
    };
  };
}
