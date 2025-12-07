{
  lib,
  config,
  pkgs,
  ...
}:
let
  pythonPackages = with pkgs.python313Packages; [
    pip
    opencv4
    opencv-python
  ];
in {
  options = {
    setup.cli-apps.python.enable = lib.mkEnableOption "Python";
  };

  config = lib.mkIf config.setup.cli-apps.python.enable {
    home.packages = with pkgs; [
      (python3.withPackages (ppkgs: pythonPackages))
      ninja
    ];

    programs.uv.enable = true;
  };
}
