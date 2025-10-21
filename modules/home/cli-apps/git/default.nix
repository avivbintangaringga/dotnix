{
  lib,
  config,
  userdata,
  ...
}:
{
  options = {
    setup.cli-apps.git.enable = lib.mkEnableOption "Git";
  };

  config = lib.mkIf config.setup.cli-apps.git.enable {
    programs.git = {
      enable = true;
      settings = {
        user = {
          name = userdata.git.username;
          email = userdata.git.email;
        };
        init.defaultBranch = "main";
      };
    };

    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
  };
}
