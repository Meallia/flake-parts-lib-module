{ inputs, ... }:

{
  imports = [
    inputs.pre-commit-hooks-nix.flakeModule
  ];
  systems = inputs.nixpkgs.lib.systems.flakeExposed;

  perSystem = { config, pkgs, ... }: {

    devShells.default = pkgs.mkShell {
      shellHook = ''
        ${config.pre-commit.shellHook}
      '';
    };

    pre-commit = {
      inherit pkgs;
      settings = {
        hooks = {
          nixpkgs-fmt.enable = true;
          nil.enable = true;
          deadnix.enable = true;
          end-of-file-fixer.enable = true;
        };
      };
    };
  };
}
