{ userdata, ... }:
{
  programs.git = {
    enable = true;
    userName = userdata.username;
    userEmail = userdata.email;
  };
}
