{
  plugins.harpoon = {
    enable = true;
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader><A-f>";
      action.__raw = "function() require'harpoon':list():add() end";
    }
    {
      mode = "n";
      key = "<A-f>";
      action.__raw = "function() require'harpoon'.ui:toggle_quick_menu(require'harpoon':list()) end";
    }
    {
      mode = "n";
      key = "<A-n>";
      action.__raw = "function() require'harpoon':list():select(1) end";
    }
    {
      mode = "n";
      key = "<A-e>";
      action.__raw = "function() require'harpoon':list():select(2) end";
    }
    {
      mode = "n";
      key = "<A-a>";
      action.__raw = "function() require'harpoon':list():select(3) end";
    }
    {
      mode = "n";
      key = "<A-i>";
      action.__raw = "function() require'harpoon':list():select(4) end";
    }
  ];
}
