{
  inputs,
  ...
}:
{
  imports = [
    inputs.devenv.flakeModule
    inputs.treefmt-nix.flakeModule
  ];

  config.perSystem =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      config = {
        devenv.shells.default = {
          packages = config.treefmt.build.devShell.nativeBuildInputs;

          languages = {
            nix = {
              enable = true;
              lsp.package = pkgs.nixd;
            };
          };

          containers = lib.mkForce { };
        };

        treefmt.programs = {
          nixfmt.enable = true;
        };
      };
    };
}
