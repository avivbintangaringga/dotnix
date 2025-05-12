{ userdata, ... }:
{
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
}
