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
      action = "<cmd>ReplRunCell<cr>";
      options = {desc = "Evaluate cell and move to next";};
    }
    {
      mode = "n";
      key = "<leader>E";
      action = "<cmd>ReplRunAndMove<cr>";
      options = {desc = "Evaluate cell";};
    }
    {
      mode = "n";
      key = "<leader>>";
      action = "<cmd>lua require('notebook-navigator').move_cell('d')<cr>";
      options = {desc = "Evaluate cell";};
    }
    {
      mode = "n";
      key = "<leader><";
      action = "<cmd>lua require('notebook-navigator').move_cell('u')<cr>";
      options = {desc = "Evaluate cell";};
    }
    {
      mode = "v";
      key = "<leader>e";
      action = "<cmd>ReplSendVisualSelection<cr>";
      options = {desc = "Evaluate Visual Selection";};
    }
  ];

  extraPackages = [pkgs.neovim-remote]; # for julia to handle @edit

  extraConfigLua = ''
    require("notebook-navigator").setup({
      activate_hydra_keys = nil,
      hydra_keys = { },
        show_hydra_hint = false,
      })

    local Terminal = require('toggleterm.terminal').Terminal
    local ipython_id = 73
    local julia_id = 42
    local ipython = Terminal:new({cmd="ipython --no-autoindent", close_on_exit=true, direction="vertical", display_name="ipython", count=ipython_id})
    local julia = Terminal:new({cmd="julia", env = {VISUAL="nvr -cc vsplit --remote-wait +'set bufhidden=wipe'"}, close_on_exit=true, direction="vertical", display_name="julia", count=julia_id})

    function _get_repl_terminal_id()
        if vim.bo.filetype == "python" then
            return ipython_id
        elseif vim.bo.filetype == "julia" then
            return julia_id
        else
           error("Current filetype has no repl associated")
        end
    end

    function _repl_toggle()
        if vim.bo.filetype == "python" then
            ipython:toggle()
        elseif vim.bo.filetype == "julia" then
            julia:toggle()
        elseif vim.bo.filetype == "toggleterm" then
            require("toggleterm").toggle()
        else
           error("Current filetype has no repl associated")
        end
    end

    function _repl_spawn()
        if vim.bo.filetype == "python" then
            if require("toggleterm.terminal").get(_get_repl_terminal_id()) == nil then
              ipython:spawn()
            end
        elseif vim.bo.filetype == "julia" then
            if require("toggleterm.terminal").get(_get_repl_terminal_id()) == nil then
              julia:spawn()
            end
        else
           error("Current filetype has no repl associated")
        end
    end

    function _repl_open_or_focus()
        if vim.bo.filetype == "python" then
            if ipython:is_open() then
                ipython:focus()
            else
                ipython:open()
            end
        elseif vim.bo.filetype == "julia" then
            if julia:is_open() then
                julia:focus()
            else
                julia:open()
            end
        else
           error("Current filetype has no repl associated")
        end
    end

    vim.api.nvim_create_user_command('ToggleJuliaWrap', function()
            vim.g.julia_wrapping_enabled = not vim.g.julia_wrapping_enabled
        end, {})
    vim.g.julia_wrapping_enabled = true
    -- This function controls code run on the beginning of each cell
    function _cell_init()
        if vim.bo.filetype == "python" then
            -- do nothing
        elseif vim.bo.filetype == "julia"  then
            if vim.g.julia_wrapping_enabled then
              send_julia_begin()
            end
        else
           error("Current filetype has no repl associated")
        end
    end

    function _cell_finish()
        if vim.bo.filetype == "python" then
            -- do nothing
        elseif vim.bo.filetype == "julia" then
            if vim.g.julia_wrapping_enabled then
              send_julia_end()
            end
        else
           error("Current filetype has no repl associated")
        end
    end

    function send_esc()
      local esc = vim.api.nvim_replace_termcodes("<esc>", true, false, true)
      vim.api.nvim_feedkeys(esc, "x", false)
    end


    function send_julia_begin()
      require("toggleterm").exec("begin", _get_repl_terminal_id())
    end
    function send_julia_end()
      require("toggleterm").exec("end", _get_repl_terminal_id())
    end

    --https://github.com/akinsho/toggleterm.nvim/issues/425#issuecomment-1854373704
    function send_visual_lines()
      -- visual markers only update after leaving visual mode
      send_esc()

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
      require("toggleterm").exec(cmd, _get_repl_terminal_id())
    end


    vim.api.nvim_create_user_command('ReplToggle', function()
        id = _get_repl_terminal_id()
        _repl_spawn()
        _repl_toggle()
      end,
    {})
    vim.api.nvim_create_user_command('ReplRunAndMove', function()
        id = _get_repl_terminal_id()
        _repl_spawn()
        _cell_init()
        require("notebook-navigator").run_and_move({id=id})
        _cell_finish()
      end,
    {})
    vim.api.nvim_create_user_command('ReplRunCell', function()
        id = _get_repl_terminal_id()
        _repl_spawn()
        _cell_init()
        require("notebook-navigator").run_cell({id=id})
        _cell_finish()
      end,
    {})

    -- taken from: https://github.com/akinsho/toggleterm.nvim?tab=readme-ov-file#sending-lines-to-the-terminal
    local trim_spaces = false
    vim.api.nvim_create_user_command('ReplSendLine', function()
        id = _get_repl_terminal_id()
        _repl_spawn()
        _cell_init()
        require("toggleterm").send_lines_to_terminal("single_line", trim_spaces, { args = id })
        _cell_finish()
      end,
    {})

    -- this should be called only in Visual or Visual-Lines modes
    vim.api.nvim_create_user_command('ReplSendVisualSelection', function()
      id = _get_repl_terminal_id()
      _repl_spawn()
      local toggleterm = require("toggleterm")
      _cell_init()
      if vim.api.nvim_get_mode().mode == 'V' then
        send_visual_lines()
      else
        toggleterm.send_lines_to_terminal("visual_selection", trim_spaces, { args = id })
      end
      _cell_finish()
      end,
    {})
  '';
}
