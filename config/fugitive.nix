{
  plugins.fugitive.enable = true;
  keymaps = [
    {
      mode = "n";
      key = "jp";
      action = "<cmd>diffput<cr>";
    }
    {
      mode = "n";
      key = "jg";
      action = "<cmd>diffget<cr>";
    }
    {
      mode = "n";
      key = "j<Left>";
      action = "<cmd>diffget \\2<cr>";
    }
    {
      mode = "n";
      key = "j<Right>";
      action = "<cmd>diffget \\3<cr>";
    }
  ];
}
