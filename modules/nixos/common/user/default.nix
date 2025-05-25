{ userdata, ... }:
{
  users = {
    users.${userdata.username} = {
      isNormalUser = true;
      initialPassword = "123";
      extraGroups = [ "wheel" ];
    };
  };
}
