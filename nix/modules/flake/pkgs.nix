{
  lib,
  self,
  inputs,
  ...
}:
{
  config.perSystem =
    { system, ... }:
    {
      _module.args.pkgs = import inputs.nixpkgs {
        inherit system;
        overlays = lib.attrsets.attrValues self.overlays;
      };
    };
}
