{
  # TODO: configure with -> https://git.sr.ht/~whynothugo/lsp_lines.nvim
  plugins.lsp-lines = {enable = true;};
  keymaps = [
    {
      mode = "n";
      key = "hl";
      action = "<cmd>lua require('lsp_lines').toggle()<cr>";
      options = {desc = "Toggle lsp_lines";};
    }
  ];
}
