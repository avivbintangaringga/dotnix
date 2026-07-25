{
  den.schema.home = { lib, ... }: {
    options = {
      fullName = lib.mkOption {
        type = lib.types.str;
        default = "";
        description = "Full name";
      };

      git = {
        userName = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Git username";
        };

        email = lib.mkOption {
          type = lib.types.str;
          default = "";
          description = "Git email";
        };
      };
    };
  };
}
