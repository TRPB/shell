{
  lib,
  config,
  ...
}:
{
  options.trpb.shell = {
    name = lib.mkOption {
      type = lib.types.str;
      default = config._module.args.name;
      description = "Name of user";
    };

    enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable the terminal config for user <name>";
    };

    execInBash = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable automatically switch to fish after launching bash (for not using fish as login shell)";
    };

  };
}
