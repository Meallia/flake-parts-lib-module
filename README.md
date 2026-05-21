# flake-parts lib module

By default, `flake-parts` does not allow you to define `flake.lib.xxx` in multiple modules.
If you attempt to set attributes under `flake.lib` in more than one flake module,
`flake-parts` will throw a conflict error because the option isn't configured to merge attribute sets automatically.
This limitation makes it difficult to organize library functions into logical groups across different files.
This flake module provides a definition for `flake.lib` using `lazyAttrsOf anything`.
This change allows you to define library functions across multiple modules seamlessly.
The module will automatically merge all declarations into the final `flake.lib` output of your flake.

* Add this flake to your inputs:
```nix
{
  inputs.flake-parts-lib-module.url = "github:meallia/flake-parts-lib-module";
  inputs.flake-parts-lib-module.inputs.flake-parts.follows = "flake-parts";
}
```
* Import the module into your `mkFlake`:
```nix
{
  outputs = inputs@{ flake-parts, flake-parts-lib-module, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        flake-parts-lib-module.flakeModule
      ];
      # Now you can define flake.lib here...
      flake.lib.hello = name: "Hello ${name}";
    };
}
```
* And define it in other modules as well:
```nix
{
  flake.lib.utils = {
    mkExample = x: x;
  };
}
```
Both definitions will coexist in your flake's `lib` output without conflicts.
