{full, ...}: let
  basic = [
    ./options.nix
    ./keymaps.nix
    ./autocmd.nix
    ./undotree.nix
    ./clipboard.nix
    ./smart-splits.nix
    ./colorscheme.nix
    ./kitty-scrollback.nix
    ./leap.nix
    ./debugging.nix
    ./cloak.nix
  ];
  code = [
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
    ./conform.nix
    ./todo-comments.nix
    ./devdocs.nix
  ];
  git = [
    ./git.nix
  ];
  navigation = [
    ./telescope.nix
    ./nnn.nix
    ./harpoon.nix
  ];
  extraAppearance = [
    ./noice.nix
    ./dressing.nix
    ./lualine.nix
    ./image.nix
    ./ufo-fold.nix
  ];
  integrations = [
    ./krita.nix
    ./notebook.nix
    ./asyncrun.nix
    ./toggle-term.nix
    ./neorg.nix
    ./gp.nix
    ./markdown-preview.nix
    ./dadbod.nix
    ./hurl.nix
  ];
  imports =
    basic
    ++ (
      if full
      then navigation
      else []
    )
    ++ (
      if full
      then code
      else []
    )
    ++ (
      if full
      then git
      else []
    )
    ++ (
      if full
      then extraAppearance
      else []
    )
    ++ (
      if full
      then integrations
      else []
    );
in {
  inherit imports;
}
