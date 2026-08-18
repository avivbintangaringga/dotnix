{
  dotnix,
  ...
}:
{
  dotnix.programming.includes = with dotnix; [
    go
    js
    lsp
    luau
    nix
    php
    python
  ];
}
