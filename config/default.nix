{
  # Import all your configuration modules here
  imports = [
    ./options.nix
    ./mappings.nix
    ./autocmd.nix
    ./undotree.nix

    # code
    ./completion.nix
    ./comments.nix
    ./lsp-lines.nix
    ./indent-blankline.nix

    # navigation
    ./telescope.nix
    ./leap.nix
#    ./harpoon.nix

    # visuals
    ./colorscheme.nix
    ./noice.nix
    ./lualine.nix
    # TODO: add dressing.nvim

    # other
    ./extraConfigLua.nix
  ];
}
