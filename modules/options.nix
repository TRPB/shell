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
  };
}
