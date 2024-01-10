{ ... }:
{
  # Import all your configuration modules here
  imports = [
    ./options.nix
    ./mappings.nix
    ./autocmd.nix
    ./undotree.nix
    ./clipboard.nix

    # code
    ./lsp.nix
    ./dap.nix
    ./dap-python.nix
    ./fidget.nix
    ./treesitter.nix
    ./completion.nix
    ./snippets.nix
    ./comments.nix
    ./lsp-lines.nix
    ./indent-blankline.nix
    ./vimtex.nix

    # git
    ./gitsigns.nix
    ./fugitive.nix

    # navigation
    ./telescope.nix
    ./nnn.nix
    ./leap.nix
    ./harpoon.nix
    ./smart-splits.nix

    # visuals
    ./colorscheme.nix
    ./noice.nix
    ./dressing.nix
    ./lualine.nix
    ./nabla.nix
    ./image.nix

    # other
    ./notebook.nix
    ./asyncrun.nix
    ./toggle-term.nix
    ./todo-comments.nix
    ./neorg.nix
    ./chatgpt.nix
    ./markdown-preview.nix
    ./extraConfigLua.nix
  ];
}
