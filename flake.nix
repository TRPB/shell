{
  description = "Shell config abstracted to it's own flake";

  outputs =
    {
      self,
    }:
    {
      homeManagerModules.shell = ./modules/shell.nix;
    };
}
