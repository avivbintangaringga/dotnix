{ lib, config, userdata, ... }:
{
  options = {
    setup.cli-apps.git.enable = lib.mkEnableOption "Git";
  };

  config = lib.mkIf config.setup.cli-apps.git.enable {
    programs.git = {
      enable = true;
      userName = userdata.git.username;
      userEmail = userdata.git.email;
      extraConfig = {
        user.name = userdata.git.username;
        user.email = userdata.git.email;
        init.defaultBranch = "main";
      };
    };

    programs.gh = {
      enable = true;
      gitCredentialHelper.enable = true;
    };
  };
}
