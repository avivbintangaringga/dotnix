{
  inputs,
  ...
}:
{
  flake-file.inputs.pedantix = {
    url = "github:swarsel/pedantix";
  };

  dotnix.nix = {
    homeManager = { pkgs, ... }: {
      imports = [
        inputs.pedantix.homeManagerModules.default
      ];

      home.packages = with pkgs;[
        nixd
        nil
        nixfmt
      ];

      programs.pedantix = {
        enable = true;
        settings = {
          preset = "nixos-module";
          args = {
            first = [
              "self"
              "den"
              "dotnix"
              "inputs"

              "host"
              "user"
              "home"

              "config"
              "lib"
              "myLib"
              "pkgs"
              "options"
              "modulesPath"
              "utils"
            ];
            last = [ "<defaulted>" "..." ];
          };
          attrs = {
            first = [
              "flake-file"
              "includes"
              "homeManager"
              "nixos"

              "imports"
              "home"
              "environment"

              "options"
              "config"
              "enable"
              "package"
              "url"
              "inputs"
            ];
            last = [ "meta" ];
            merge = true;
            flatten = true;
          };
        };
      };
    };
  };
}
