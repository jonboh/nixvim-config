{
  plugins.toggleterm = {
    enable = true;
    settings = {
      start_in_insert = false;
      size = ''
        function(term)
          if term.direction == "horizontal" then
            return 20
          elseif term.direction == "vertical" then
            return 80
          end
        end
      '';
    };
  };
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
