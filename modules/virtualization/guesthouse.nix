{
  inputs,
  ...
}:
{
  flake-file.inputs.guesthouse = {
    inputs.nixpkgs.follows = "nixpkgs";
    url = "github:xnixy/guesthouse";
  };
}
