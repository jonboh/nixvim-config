{full, ...}: let
  basic = [
    # ./visual-mod.nix
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
    ./scrollbar.nix
  ];
  code = [
    ./lsp.nix
    ./dap.nix
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
    ./csvview.nix
    ./coq.nix
  ];
  git = [
    ./git.nix
  ];
  navigation = [
    ./telescope.nix
    ./yazi.nix
    ./harpoon.nix
  ];
  extraAppearance = [
    ./noice.nix
    ./snacks.nix
    ./lualine.nix
    ./ufo-fold.nix
  ];
  integrations = [
    ./krita.nix
    ./notebook.nix
    ./asyncrun.nix
    ./toggle-term.nix
    ./obsidian.nix
    ./gp.nix
    ./opencode.nix
    ./markdown-preview.nix
    ./dadbod.nix
    ./anki.nix
    ./azure-prs.nix
    ./just.nix
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
    )
    ++ (
      if !full
      then [./light.nix]
      else []
    );
in {
  inherit imports;
}
