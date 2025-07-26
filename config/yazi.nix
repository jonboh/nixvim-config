{pkgs, ...}: {
  plugins.yazi.enable = true;
  keymaps = [
    {
      mode = "n";
      key = "<leader>b";
      action = "<cmd>Yazi<cr>";
    }
    {
      mode = "n";
      key = "<C-b>";
      action = "<cmd>Yazi<cr>";
    }
  ];
}
