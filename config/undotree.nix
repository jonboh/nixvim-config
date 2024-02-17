{
  plugins.undotree = {
    enable = true;
    focusOnToggle = true;
    windowLayout = 2;
  };
  keymaps = [{
    mode = "n";
    key = "<leader>u";
    action = "<cmd>UndotreeToggle<CR>";
    options.desc = "Toggle Undotree";
  }];
}
