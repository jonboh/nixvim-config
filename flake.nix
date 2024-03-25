{
  description = "A nixvim configuration";

  inputs = {
    nixvim.url = "github:jonboh/nixvim_";
    # nixvim.url = "/home/jonboh/devel/nixvim_";
    flake-utils.url = "github:numtide/flake-utils";
    nixneovimplugins.url = "github:NixNeovim/NixNeovimPlugins";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    # neorg-overlay.url = "github:nvim-neorg/nixpkgs-neorg-overlay";
  };

  outputs = {
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
          inputs.neovim-nightly-overlay.overlay
          # inputs.neorg-overlay.overlays.default
          (import ./overlays/image-nvim.nix)
        ];
      };
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          nixneovimplugins.overlays.default
          # inputs.neorg-overlay.overlays.default
          (import ./overlays/image-nvim.nix)
        ];
      };
      nixvim' = nixvim.legacyPackages.${system};
      nvim-nightly = nixvim'.makeNixvimWithModule {
        pkgs = pkgs-nightly;
        module = import ./config {full = true;};
      };
      nvim = nixvim'.makeNixvimWithModule {
        inherit pkgs;
        module = import ./config {full = true;};
      };
      _nvim-light = nixvim'.makeNixvimWithModule {
        inherit pkgs;
        module = import ./config {full = false;};
      };
      nvim-light = with nixpkgs.legacyPackages.${system};
        stdenv.mkDerivation {
          name = "nvim-light";
          buildInputs = [_nvim-light];
          buildCommand = ''
            mkdir -p $out/bin
            ln -s ${_nvim-light}/bin/nvim $out/bin/nvim-light
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
        default = nvim-nightly;
        inherit nvim-nightly;
        inherit nvim;
        inherit nvim-light;
      };
    });
}
