{
  plugins.undotree = {
    enable = true;
    settings = {
      FocusOnToggle = true;
      WindowLayout = 2;
    };
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>u";
      action = "<cmd>UndotreeToggle<CR>";
      options.desc = "Toggle Undotree";
    }
  ];
}
