{pkgs, ...}: {
  extraPlugins = [pkgs.vimExtraPlugins.nvim-devdocs];

  extraConfigLua = ''
    require("nvim-devdocs").setup({
      ensure_installed = {"rust", "nix", "python-3.11"}, -- get automatically installed
      })
  '';

  keymaps = [
    {
      mode = "n";
      key = "<C-h>";
      action = "<cmd>DevdocsOpenCurrent<cr>";
    }
    {
      mode = "n";
      key = "<CS-h>";
      action = "<cmd>DevdocsOpen<cr>";
    }
  ];
}
