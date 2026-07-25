{
  den,
  ...
}:
{
  den.aspects.editors = {
    provides = {
      cli.includes = with den.aspects; [
        helix
        nvim
      ];

      gui.includes = with den.aspects; [

      ];

      gui-extra.includes = with den.aspects; [

      ];

      minimal.includes = with den.aspects.editors; [
        cli
        gui
      ];

      full.includes = with den.aspects.editors; [
        cli
        gui
        gui-extra
      ];
    };
  };
}
