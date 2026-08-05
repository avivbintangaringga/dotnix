{
  dotnix.netbeans.homeManager = { pkgs, ... }: {
    home = {
      packages = with pkgs; [
        jre
        netbeans
      ];
      sessionVariables = {
        AWT_TOOLKIT = "MToolkit";
        _JAVA_AWT_WM_NONREPARENTING = 1;
      };
    };
  };
}
