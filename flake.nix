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

    # doom-emacs-config = {
    #   url = "github:unholynuisance/.doom.d";
    #   flake = false;
    # };
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./nix/modules/flake/shells.nix
        ./nix/modules/flake/pkgs.nix
      ];

      config = {
        systems = [
          "x86_64-linux"
        ];

        flake.overlays = {
          nix-doom-emacs-unstraightened = inputs.nix-doom-emacs-unstraightened.overlays.default;
        };

        perSystem =
          {
            pkgs,
            ...
          }:
          {
            packages = rec {
              default = doom-emacs;
              doom-emacs = pkgs.emacsWithDoom {
                doomDir = ./.;
                doomLocalDir = "~/.local/share/nix-doom";
                tangleArgs = ".";
                extraPackages = epkgs: [ epkgs.treesit-grammars.with-all-grammars ];
              };
            };
          };
      };
    };
}
