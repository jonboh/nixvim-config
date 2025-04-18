{pkgs, ...}: {
  extraPlugins = [pkgs.vimExtraPlugins.nvim-devdocs];

  extraConfigLua = ''
    require("nvim-devdocs").setup({
      ensure_installed = { -- get automatically installed
        "rust",
        "nix",
        "lua-5.1",
        "latex",
        "python-3.11",
        "numpy-1.23",
        "pandas-1",
        "matplotlib-3.7",
        "pytorch-2",
        "scikit_learn",
        "bash",
        "jq",
        "postgresql-16",
        "influxdata",
        "html",
        "haskell-9"
        },
      })
  '';

  keymaps = [
    {
      mode = "n";
      key = "<leader>doc";
      action = "<cmd>DevdocsOpenCurrent<cr>";
    }
    {
      mode = "n";
      key = "<leader><leader>doc";
      action = "<cmd>DevdocsOpen<cr>";
    }
  ];
}
