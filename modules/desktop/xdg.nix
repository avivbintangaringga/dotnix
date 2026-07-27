{
  dotnix.xdg.homeManager.xdg = {
    configFile."mimeapps.list".force = true;
    mimeApps.enable = true;
    portal = {
      enable = true;
      xdgOpenUsePortal = true;
    };
    terminal-exec.enable = true;
    userDirs = {
      enable = true;
      setSessionVariables = true;
    };
  };
}
