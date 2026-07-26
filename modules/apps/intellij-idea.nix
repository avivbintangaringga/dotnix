{
  den.aspects.intellij-idea = {
    homeManager = { pkgs, ... }: {
      home.packages = with pkgs; [
        jetbrains.idea
      ];
    };
  };
}
