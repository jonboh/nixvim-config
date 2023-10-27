{ ... }:
{
  # Import all your configuration modules here
  imports = [
    ./options.nix
    ./mappings.nix
    ./autocmd.nix
    ./undotree.nix

    # code
    ./lsp.nix
    ./dap.nix
    ./fidget.nix
    ./treesitter.nix
    ./completion.nix
    ./snippets.nix
    ./comments.nix
    ./lsp-lines.nix
    ./indent-blankline.nix

    # navigation
    ./telescope.nix
    ./leap.nix
    ./harpoon.nix

    # visuals
    ./colorscheme.nix
    ./noice.nix
    ./dressing.nix
    ./lualine.nix

    # other
    ./toggle-term.nix
    ./todo-comments.nix
    ./neorg.nix
    ./chatgpt.nix
    ./extraConfigLua.nix


  ];
}
