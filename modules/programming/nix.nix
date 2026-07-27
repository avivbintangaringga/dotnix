{
  inputs,
  ...
}:
{
  flake-file.inputs.pedantix.url = "github:swarsel/pedantix";

  dotnix.nix = {
    homeManager = { pkgs, ... }: {
      imports = [
        inputs.pedantix.homeManagerModules.default
      ];

      home.packages = with pkgs; [
        nixd
        nil
        nixfmt
      ];

      programs.pedantix = {
        enable = true;
        settings = {
          top-level-blank-lines = 1;
          overrides = [
            {
              attrs.first = [ "url" ];
              path = "inputs";
            }
            {
              attrs.blank-lines = 1;
              path = "flake-file.inputs";
            }
          ];
          args = {
            first = [
              "self"
              "name"
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
              "utils"
            ];
            last = [
              "modulesPath"
              "<defaulted>"
              "..."
            ];
          };
          attrs = {
            first = [
              "url"
              "inputs"
              "flake-file"
              "flake"

              "includes"
              "homeManager"
              "nixos"
              "imports"

              "options"
              "config"
              "enable"
              "package"

              "home"
              "environment"

              "programs"
              "services"
            ];
            last = [ "meta" ];
            flatten = true;
            merge = true;
          };
          inherits = {
            sort = true;
            first = [
              "self"
              "name"
              "homeConfig"
              "inputs"
              "config"
              "lib"
              "pkgs"
              "options"
              "modulesPath"
            ];
          };
        };
      };
    };
  };
}
