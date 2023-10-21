{
  plugins = {
    lsp = {
      enable = true;
      servers = {
        lua-ls.enable = true;
        rnix-lsp.enable = true;
      };
    };
    lsp-format = {
      enable = true;
    };

    lspkind.enable = true;

    rust-tools = {
      enable = true;
      server.check.command = "clippy";
    };
  };
# TODO: add all keybinds
  keymaps = [
    {
      mode = "n";
      key = "hx";
      action = "<cmd>lua vim.diagnostic.setqflist()<cr><cmd>cfirst<cr>";
      options = {
        silent = true;
        desc = "Load LSP Diagnostics to qf";
      };
    }
  ];
}
