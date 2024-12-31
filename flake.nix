{
  description = "A nixvim configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixvim.url = "github:jonboh/nixvim";
    # nixvim.url = "/home/jonboh/devel/nixvim";
    # nixvim.url = "github:nix-community/nixvim";
    flake-utils.url = "github:numtide/flake-utils";
    nixneovimplugins.url = "github:NixNeovim/NixNeovimPlugins";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = {
    self,
    nixpkgs,
    nixvim,
    flake-utils,
    nixneovimplugins,
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      nixvimLib = nixvim.lib.${system};
      pkgs-nightly = import nixpkgs {
        inherit system;
        overlays = [
          nixneovimplugins.overlays.default
          inputs.neovim-nightly-overlay.overlays.default
        ];
      };
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          nixneovimplugins.overlays.default
        ];
      };
      nixvim' = nixvim.legacyPackages.${system};
      nvim-nightly = nixvim'.makeNixvimWithModule {
        pkgs = pkgs-nightly;
        extraSpecialArgs = {
          inherit self;
          binname = "nixvim-nightly";
        };
        module = import ./config {full = true;};
      };
      nvim = nixvim'.makeNixvimWithModule {
        inherit pkgs;
        extraSpecialArgs = {
          inherit self;
          binname = "nixvim";
        };
        module = import ./config {full = true;};
      };
      nvim-light = nixvim'.makeNixvimWithModule {
        inherit pkgs;
        extraSpecialArgs = {
          inherit self;
          binname = "nixvim-light";
        };
        module = import ./config {full = false;};
      };
      nixvim-nightly-config = with nixpkgs.legacyPackages.${system};
        stdenv.mkDerivation {
          name = "nixvim-nightly-config";
          buildInputs = [nvim-nightly];
          buildCommand = ''
            mkdir -p $out/bin
            ln -s ${nvim-nightly}/bin/nvim $out/bin/nixvim-nightly
            ln -s ${nvim-nightly}/bin/nixvim-print-init $out/bin/nixvim-print-init
          '';
        };
      nixvim-config = with nixpkgs.legacyPackages.${system};
        stdenv.mkDerivation {
          name = "nixvim-config";
          buildInputs = [nvim];
          buildCommand = ''
            mkdir -p $out/bin
            ln -s ${nvim}/bin/nvim $out/bin/nixvim
            ln -s ${nvim}/bin/nixvim-print-init $out/bin/nixvim-print-init
          '';
        };
      nixvim-light-config = with nixpkgs.legacyPackages.${system};
        stdenv.mkDerivation {
          name = "nixvim-light-config";
          buildInputs = [nvim-light];
          buildCommand = ''
            mkdir -p $out/bin
            ln -s ${nvim-light}/bin/nvim $out/bin/nixvim-light
            ln -s ${nvim-light}/bin/nixvim-print-init $out/bin/nixvim-print-init
          '';
        };
    in {
      checks = {
        # Run `nix flake check .` to verify that your config is not broken
        default = nixvimLib.check.mkTestDerivationFromNvim {
          inherit nvim;
          name = "A nixvim configuration";
        };
      };

      packages = {
        default = nixvim-nightly-config;
        inherit nixvim-nightly-config;
        inherit nixvim-config;
        nixvim-light-config = nixvim-light-config;
      };
    });
}
