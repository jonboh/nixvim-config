{pkgs, ...}: {
  extraPlugins = [
    pkgs.vimExtraPlugins.NotebookNavigator-nvim
    # NOTE: we don't need to use hydra if we dont use the extra mode
    # pkgs.vimPlugins.hydra-nvim
  ];

  keymaps = [
    {
      mode = "n";
      key = "<leader>x";
      action = "<cmd>lua require('notebook-navigator').run_and_move()<cr>";
      options = {desc = "Run cell and move to next";};
    }
    {
      mode = "n";
      key = "<leader>X";
      action = "<cmd>lua require('notebook-navigator').run_cell()<cr>";
      options = {desc = "Run cell";};
    }
    {
      mode = "n";
      key = ">c";
      action = "<cmd>lua require('notebook-navigator').move_cell('d')<cr>";
      options = {desc = "Run cell";};
    }
    {
      mode = "n";
      key = "<c";
      action = "<cmd>lua require('notebook-navigator').move_cell('u')<cr>";
      options = {desc = "Run cell";};
    }
  ];

  extraConfigLua = ''
    require("notebook-navigator").setup({
      activate_hydra_keys = nil,
      hydra_keys = {
         -- comment = "gC",
         -- run = "<C-X>",
         -- run_and_move = "X",
         -- move_up = "<S-Up>",
         -- move_down = "<S-Down>",
         -- add_cell_before = "<C-I>",
         -- add_cell_before = "<C-A>"
        },
        show_hydra_hint = false,
      })
  '';
}
