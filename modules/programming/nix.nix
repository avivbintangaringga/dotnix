{
  inputs,
  ...
}:
{
  flake-file.inputs.pedantix.url = "github:swarsel/pedantix";

  dotnix.nix.homeManager = { pkgs, ... }: {
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
          flatten = true;
          last = [ "meta" ];
          merge = true;
        };
        inherits = {
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
          sort = true;
        };
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
        top-level-blank-lines = 1;
      };
    };
  };
}
