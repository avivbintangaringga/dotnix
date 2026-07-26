{
  dotnix.xdg = {
    homeManager = {
      xdg = {
        configFile = {
          "mimeapps.list".force = true;
        };

        portal = {
          enable = true;
          xdgOpenUsePortal = true;
        };

        mimeApps = {
          enable = true;
        };

        terminal-exec = {
          enable = true;
        };

        userDirs = {
          enable = true;
          setSessionVariables = true;
        };
      };
    };
  };
}
