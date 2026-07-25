{
  den.aspects.base = { den, ... }: {
    includes = with den.aspects; [
      accounts-daemon
    ];
  };
}
