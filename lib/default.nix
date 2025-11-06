{
  enabled = {
    enable = true;
  };

  disabled = {
    enable = false;
  };

  listToAttrsSameValue =
    list: value:
    builtins.listToAttrs (
      builtins.map (name: {
        name = name;
        value = value;
      }) list
    );
}
