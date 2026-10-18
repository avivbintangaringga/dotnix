{
  dotnix.python.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [
      (python3.withPackages (ppkgs: with ppkgs; [
        pip
        numpy
        onnxruntime
        pillow
      ]))
      ruff
    ];
    programs.uv.enable = true;
  };
}
