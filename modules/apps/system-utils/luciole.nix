{
  inputs,
  ...
}:
{
  dotnix.luciole = {
    homeManager = {
      imports = [
        inputs.luciole.homeModules.default
      ];

      programs.luciole.enable = true;
    };
  };
  flake-file.inputs.luciole = {
    url = "github:noctalia-dev/luciole";
  };
}
