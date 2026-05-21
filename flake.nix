{
  description = "mergeable `flake.lib` flake-parts module";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } (
      { ... }:
      let
      	flakeModules.default = ./lib-flake-module.nix;
      in
      {
        systems = [ ];
        imports = [
          flake-parts.flakeModules.flakeModules
          flake-parts.flakeModules.partitions
          flakeModules.default
        ];

        flake = {
          inherit flakeModules;
        };

        partitionedAttrs = {
          checks = "dev";
          devShells = "dev";
        };
        partitions.dev = {
          extraInputsFlake = ./dev;
          module = { imports = [ ./dev/flake-module.nix ]; };
        };
      }

    );

}
