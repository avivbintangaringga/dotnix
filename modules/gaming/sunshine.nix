{
  dotnix.sunshine.nixos = { user, ... }: {
    services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };
    hardware.uinput.enable = true;
    users.users.${user.userName}.extraGroups = [ "uinput" ];
  };
}
