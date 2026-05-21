{ lib, ... }:
let
  inherit (lib) mkOption types;
  inherit (types) lazyAttrsOf anything;
in
{
  options.flake.lib = mkOption {
    type = lazyAttrsOf anything;
    default = { };
    description = ''
      	Nix functions for use by any other flake.

      	Allows defining `flake.lib` in multiple flake-parts modules.
    '';
  };
}
