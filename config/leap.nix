{
  plugins.leap = {
    enable = true;
    settings = {
      labels = ["d" "n" "r" "e" "c" "l" "u" "l" "D" "N" "R" "E" "L" "C" "U"];
      safeLabels = ["n" "r" "t" "c" "u"];
    };
  };
  extraConfigLua = ''
    vim.keymap.set({'n', 'x', 'o'}, 'l',  '<Plug>(leap-forward)')
    vim.keymap.set({'n', 'x', 'o'}, 'L',  '<Plug>(leap-backward)')
    -- vim.keymap.del({'n', 'x', 'o'}, 's')
    -- vim.keymap.del({'n', 'x', 'o'}, 'S')
  '';
}
