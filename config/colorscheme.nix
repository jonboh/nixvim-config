{
  config = {
    colorschemes.tokyonight = {
      enable = true;
      style = "night";
      transparent = true;
      terminalColors = true;
      dayBrightness = 0;
      dimInactive = true;
      styles = {
        comments = {italic = true;};
        keywords = {italic = false;};
        functions = {};
        variables = {};
      };
    };
    options = {termguicolors = true;};
    extraConfigLua = ''
      vim.opt.background = "dark"
      vim.api.nvim_set_hl(0, "LineNr", {fg="#B1A6F7"})
      vim.api.nvim_set_hl(0, "CursorLineNr", {fg="#af00af"})

      local config = {
          normal_cursor_color = '#bbc2cf',
          visual_cursor_color = '#51afef',
          insert_cursor_color = '#98be65',
          normal_cursor_shape = 'block',
          visual_cursor_shape = 'block',
          insert_cursor_shape = 'ver25',
          extra_cursor_config = 'r-cr:hor20,o:hor50',
      }

      vim.cmd(
          "set guicursor=n-c:" ..
          config.normal_cursor_shape ..
          "-CursorN/lCursorN,v:" ..
          config.visual_cursor_shape ..
          "-CursorV/lCursorV,i-ci-ve:" .. config.insert_cursor_shape .. "-CursorI/lCursorI,"..config.extra_cursor_config)

      -- Normal mode
      vim.api.nvim_create_autocmd("ModeChanged", {
          pattern = "*:n*",
          callback = function()
              vim.cmd("hi CursorN guifg=" .. config.normal_cursor_color .. " guibg=" .. config.normal_cursor_color)
          end
      })
      -- Visual modes
      vim.api.nvim_create_autocmd("ModeChanged", {
          pattern = "*:[vV\x16]*",
          callback = function()
              vim.cmd("hi CursorV guifg=" .. config.visual_cursor_color .. " guibg=" .. config.visual_cursor_color)
          end
      })
      -- Insert mode
      vim.api.nvim_create_autocmd("ModeChanged", {
          pattern = "*:i*",
          callback = function()
              vim.cmd("hi CursorI guifg=" .. config.insert_cursor_color .. " guibg=" .. config.insert_cursor_color)
          end
      })

    '';
  };
}
