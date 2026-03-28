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
            pkgs,
            inputs',
            ...
          }:
          {
            packages =
              let
                pkg = inputs'.nix-doom-emacs-unstraightened.packages.emacs-with-doom;
                pkg' = pkg.override (prev: {
                  extraBinPackages = [
                    pkgs.nodejs_latest
                    pkgs.tree
                    pkgs.uv
                  ];
                  extraPackages = epkgs: [
                    epkgs.treesit-grammars.with-all-grammars
                  ];
                  doomDir = ./.;
                  tangleArgs = ".";
                  doomLocalDir = "~/.local/share/doom/.local";
                  profileName = "test";
                });
              in
              {
                emacs-with-doom = pkg'.override {
                  emacs = pkgs.emacs;
                };

                emacs-with-doom-pgtk = pkg'.override {
                  emacs = pkgs.emacs-pgtk;
                };
              };
          };
      };
    };
}
