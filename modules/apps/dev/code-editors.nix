{
  dotnix,
  ...
}:
{
  dotnix.code-editors = {
    includes = with dotnix; [
      code-editors.full
    ];

    provides = {
      cli.includes = with dotnix; [
        helix
        nvim
      ];
      full.includes = with dotnix.code-editors; [
        cli
        gui
        gui-extra
        ide
      ];
      gui.includes = with dotnix; [
        gedit
        zed-editor
      ];
      gui-extra.includes = with dotnix; [
        vscode
      ];
      ide.includes = with dotnix; [
        android-studio
        intellij-idea
        netbeans
      ];
      minimal.includes = with dotnix.code-editors; [
        cli
        gui
      ];
    };
  };
}
