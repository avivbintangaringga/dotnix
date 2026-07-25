{
  inputs,
  den,
  ...
}:
{
  den.aspects.noctalia = {
    includes = with den.aspects; [
      noctalia-greeter
    ];

    homeManager = {
      imports = [
        inputs.noctalia.homeModules.default
      ];

      programs.noctalia = {
        enable = true;
      };
    };
  };
}
