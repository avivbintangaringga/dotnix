{
  den,
  ...
}:
{
  den.aspects.programming = {
    includes = with den.aspects; [
      go
      js
      lsp
      luau
      nix
      python
    ];
  };
}
