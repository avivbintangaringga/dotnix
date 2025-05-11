{ pkgs, ... }:
let
  userdata = rec {
     username = "r7fx";
     userpath = "/home/" + username;
     fullname = "R7FX";
     email = "avivbintangaringga90@gmail.com";
  };
in
{
  imports = [
    #./configs
  ];
}
