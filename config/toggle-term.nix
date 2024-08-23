{
  plugins.toggleterm = {enable = true;};
  keymaps = [
    {
      mode = "n";
      key = "<A-Enter>";
      action = "<cmd>ToggleTerm direction='vertical' size=80<cr>";
    }
    {
      mode = "n";
      key = "<AS-Enter>";
      action = "<cmd>ToggleTerm direction='horizontal' size=20<cr>";
    }
    {
      mode = "t";
      key = "<A-Enter>";
      action = "<cmd>ToggleTerm<cr>";
    }
    {
      mode = "t";
      key = "<AS-Enter>";
      action = "<cmd>ToggleTerm<cr>";
    }
  ];
}
