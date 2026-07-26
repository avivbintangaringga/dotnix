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
        gedit
      ];

      gui-extra.includes = with den.aspects; [

      ];

      ide.includes = with den.aspects; [
        android-studio
        intellij-idea
      ];

      minimal.includes = with den.aspects.editors; [
        cli
        gui
      ];

      full.includes = with den.aspects.editors; [
        cli
        gui
        gui-extra
        ide
      ];
    };
  };
}
