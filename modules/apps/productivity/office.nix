{
  dotnix,
  ...
}:
{
  dotnix.office = {
    homeManager = { pkgs, ... }: {
      home = {
        packages = with pkgs; [
          libreoffice-qt-stable
        ];
        sessionVariables.SAL_USE_VCLPLUGIN = "kf6";
      };
      nixpkgs.config.problems.handlers."gtk+".broken = "warn";
      programs.onlyoffice.enable = true;
    };
    includes = with dotnix; [
      bluemail
      wpsoffice
    ];
  };
}
