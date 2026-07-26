{
  den.schema.home = { lib, ... }: {
    options = {
      fullName = lib.mkOption {
        default = "";
        description = "Full name";
        type = lib.types.str;
      };

      git = {
        email = lib.mkOption {
          default = "";
          description = "Git email";
          type = lib.types.str;
        };
        userName = lib.mkOption {
          default = "";
          description = "Git username";
          type = lib.types.str;
        };
      };
    };
  };
}
