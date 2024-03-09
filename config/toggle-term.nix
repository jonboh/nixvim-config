{
  plugins.toggleterm = {enable = true;};
  keymaps = [
    {
      mode = "n";
      key = "<A-t>";
      action = "<cmd>ToggleTerm direction='vertical' size=80<cr>";
    }
    {
      mode = "n";
      key = "<A-T>";
      action = "<cmd>ToggleTerm direction='horizontal' size=20<cr>";
    }
    {
      mode = "t";
      key = "<A-t>";
      action = "<cmd>ToggleTerm<cr>";
    }
    {
      mode = "t";
      key = "<A-T>";
      action = "<cmd>ToggleTerm<cr>";
    }
  ];
}
