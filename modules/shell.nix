{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [ ./options.nix ];

  config = lib.mkIf (config.trpb.shell.enable) (
    lib.mkMerge [
      (import ./config/fish.nix {
        pkgs = pkgs;
        config = config;
        lib = lib;
      })
      (import ./config/fzf.nix)
      (import ./config/yazi.nix)
    ]
  );
}
