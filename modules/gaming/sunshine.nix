{
  dotnix.sunshine.nixos = { user, ... }: {
    services.sunshine = {
      enable = true;
      autoStart = true;
      capSysAdmin = true;
      openFirewall = true;
    };

    users.users.${user.userName}.extraGroups = [ "uinput" ];

    hardware.uinput.enable = true;
  };
}
