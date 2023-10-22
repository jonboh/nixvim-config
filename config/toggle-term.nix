{
  plugins.toggleterm = {
    enable = true;
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader><esc>";
      action = "<cmd>ToggleTerm<cr>";
    }
    {
      mode = "t";
      key = "<leader><esc>";
      action = "<cmd>ToggleTerm<cr>";
    }
  ];
}
