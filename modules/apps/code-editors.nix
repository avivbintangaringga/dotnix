{
  den,
  ...
}:
{
  den.aspects.code-editors = {
    includes = with den.aspects; [
      code-editors.full
    ];

    provides = {
      cli.includes = with den.aspects; [
        helix
        nvim
      ];

      gui.includes = with den.aspects; [
        gedit
        zed-editor
      ];

      gui-extra.includes = with den.aspects; [
        vscode
      ];

      ide.includes = with den.aspects; [
        android-studio
        intellij-idea
      ];

      minimal.includes = with den.aspects.code-editors; [
        cli
        gui
      ];

      full.includes = with den.aspects.code-editors; [
        cli
        gui
        gui-extra
        ide
      ];
    };
  };
}
