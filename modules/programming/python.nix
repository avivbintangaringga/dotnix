{
  dotnix.python.homeManager = { pkgs, ... }: {
    home.packages = with pkgs; [
      (python3.withPackages (ppkgs: with ppkgs; [
        pycairo
        pip
        numpy
        onnxruntime
        pillow
      ]))
      ruff
      cairo
      pkg-config
    ];
    programs.uv.enable = true;
  };
}
