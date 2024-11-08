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
      key = "<leader>e";
      action = "<cmd>IPythonOpen<cr><cmd>lua require('notebook-navigator').run_and_move()<cr>";
      options = {desc = "Evaluate cell and move to next";};
    }
    {
      mode = "n";
      key = "<leader>E";
      action = "<cmd>IPythonOpen<cr>lua require('notebook-navigator').run_cell()<cr>";
      options = {desc = "Evaluate cell";};
    }
    {
      mode = "n";
      key = ">c";
      action = "<cmd>lua require('notebook-navigator').move_cell('d')<cr>";
      options = {desc = "Evaluate cell";};
    }
    {
      mode = "n";
      key = "<c";
      action = "<cmd>lua require('notebook-navigator').move_cell('u')<cr>";
      options = {desc = "Evaluate cell";};
    }
    {
      mode = "v";
      key = "<leader>e";
      action = "<cmd>IPythonSendVisual<cr>";
      options = {desc = "Evaluate Visual Selection";};
    }
  ];

  extraConfigLua = ''
    require("notebook-navigator").setup({
      activate_hydra_keys = nil,
      hydra_keys = { },
        show_hydra_hint = false,
      })

    --https://github.com/akinsho/toggleterm.nvim/issues/425#issuecomment-1854373704
    function send_visual_lines()
      -- visual markers only update after leaving visual mode
      local esc = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
      vim.api.nvim_feedkeys(esc, "x", false)

      -- get selected text
      local start_line, start_col = unpack(vim.api.nvim_buf_get_mark(0, "<"))
      local end_line, end_col = unpack(vim.api.nvim_buf_get_mark(0, ">"))
      local lines = vim.fn.getline(start_line, end_line)

      -- send selection with trimmed indent
      local cmd = ""
      local indent = nil
      for _, line in ipairs(lines) do
        if indent == nil and line:find("[^%s]") ~= nil then
          indent = line:find("[^%s]")
        end
        -- (i)python interpreter evaluates sent code on empty lines -> remove
        if not line:match("^%s*$") then
          cmd = cmd .. line:sub(indent or 1) .. string.char(13) -- trim indent
        end
      end
      require("toggleterm").exec(cmd, 1)
    end

    local function open_ipython()
      if vim.g.ipython_open == nil or vim.g.ipython_open == false then
        require("toggleterm").exec("ipython --no-autoindent", 1, 80, vim.fn.getcwd(), "vertical")
        vim.g.ipython_open = true
        P("oppened ipython")
      end
    end

    -- taken from: https://github.com/akinsho/toggleterm.nvim?tab=readme-ov-file#sending-lines-to-the-terminal
    vim.api.nvim_create_user_command('IPythonOpen', open_ipython, {})

    local trim_spaces = false
    vim.api.nvim_create_user_command('IPythonSendLine', function()
        open_ipython()
        require("toggleterm").send_lines_to_terminal("single_line", trim_spaces, { args = vim.v.count })
      end,
    {})

    -- this should be called only in Visual or Visual-Lines modes
    vim.api.nvim_create_user_command('IPythonSendVisualSelection', function()
      open_ipython()
      local toggleterm = require("toggleterm")
      if vim.api.nvim_get_mode().mode == 'V' then
        -- toggleterm.send_lines_to_terminal("visual_lines", trim_spaces, { args = vim.v.count })
        send_visual_lines()
      else
        toggleterm.send_lines_to_terminal("visual_selection", trim_spaces, { args = vim.v.count })
      end
      end,
    {})
  '';
}
