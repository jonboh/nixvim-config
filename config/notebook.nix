{pkgs, ...}: {
  extraPlugins = [
    # pkgs.vimExtraPlugins.NotebookNavigator-nvim
    # NOTE: we don't need to use hydra if we dont use the extra mode
    # pkgs.vimPlugins.hydra-nvim
    (pkgs.callPackage ../plugins/notebook.nix {})
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
    {
      mode = "v";
      key = "<leader>x";
      action = "<cmd>IPythonSendVisual<cr>";
      options = {desc = "Run Visual Selection";};
    }
  ];

  extraConfigLua = ''
    require("notebook-navigator").setup({
      activate_hydra_keys = nil,
      hydra_keys = { },
        show_hydra_hint = false,
      })

    -- taken from: https://github.com/akinsho/toggleterm.nvim?tab=readme-ov-file#sending-lines-to-the-terminal
    vim.api.nvim_create_user_command('IPythonOpen', function()
      require("toggleterm").exec("ipython --no-autoindent", 1, 80, vim.fn.getcwd(), "vertical")
      end,
    {})

    local trim_spaces = false
    vim.api.nvim_create_user_command('IPythonSendLine', function()
        require("toggleterm").send_lines_to_terminal("single_line", trim_spaces, { args = vim.v.count })
      end,
    {})

    -- this should be called only in Visual or Visual-Lines modes
    vim.api.nvim_create_user_command('IPythonSendVisualSelection', function()
      local toggleterm = require("toggleterm")
      if vim.api.nvim_get_mode().mode == 'V' then
        toggleterm.send_lines_to_terminal("visual_lines", trim_spaces, { args = vim.v.count })
      else
        toggleterm.send_lines_to_terminal("visual_selection", trim_spaces, { args = vim.v.count })
      end
      end,
    {})
  '';
}
