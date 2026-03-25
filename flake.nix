{
  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-doom-emacs-unstraightened = {
      url = "github:marienz/nix-doom-emacs-unstraightened";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./nix/modules/flake/shells.nix
      ];

      config = {
        systems = [
          "x86_64-linux"
        ];

        perSystem =
          {
            inputs',
            ...
          }:
          {
            packages = with inputs'.nix-doom-emacs-unstraightened.packages; {
              emacs-with-doom = emacs-with-doom.override {
                doomDir = ./.;
                doomLocalDir = "~/.local/share/doom/.local";
                tangleArgs = ".";
                profileName = "test";
                extraPackages = epkgs: [ epkgs.treesit-grammars.with-all-grammars ];
              };
            };
          };
      };
    };
}
