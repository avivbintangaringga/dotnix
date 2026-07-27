{
  inputs,
  ...
}:
{
  flake-file.inputs = {
    pedantix.url = "github:swarsel/pedantix";
    treefmt.url = "github:numtide/treefmt-nix";
  };

  imports = [
    inputs.treefmt.flakeModule
    inputs.pedantix.flakeModules.default
  ];

  perSystem = _: {
    treefmt = {
      programs = {
        deadnix.enable = true;
        dockerfmt.enable = true;
        gofumpt.enable = true;
        just.enable = true;
        kdlfmt.enable = true;
        ktfmt.enable = true;
        pedantix = {
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
        prettier = {
          enable = true;
          settings = {
            printWidth = 100;
            semi = false;
            singleQuote = true;
            tabWidth = 2;
            trailingComma = "all";
          };
        };
        ruff-format.enable = true;
        shfmt.enable = true;
        stylua.enable = true;
        taplo.enable = true;
        templ.enable = true;
      };
      projectRootFile = "flake.nix";
      settings.formatter.stylua.includes = [
        "*.lua"
        "*.luau"
      ];
    };
  };
}
