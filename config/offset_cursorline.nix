{
  # extraConfigLua = ''
  #   -- Configuration
  #   local level_color = { {-16, "#3A093B"},{-6, "#2B062C"},  {6, "#2C0606"}, {16, "#3B0909"}}
  #
  #   -- Plugin
  #   local ns_id = vim.api.nvim_create_namespace('offset_cursorline')
  #
  #   local function fill_space_to_end_of_window(line_offset, hl_group)
  #       return function()
  #         local win_width = vim.api.nvim_win_get_width(0)
  #         local cursor_line_nr = vim.api.nvim_win_get_cursor(0)[1]
  #         local offset_line_nr = cursor_line_nr + line_offset-1 -- WARN: this does not take into account folds
  #         -- Remove previously set extmarks, if any, to avoid stacking them
  #         vim.api.nvim_buf_del_extmark(0, ns_id, 1010+line_offset)
  #         if offset_line_nr >= 0 and offset_line_nr < vim.api.nvim_buf_line_count(0) then
  #             local line_content = vim.api.nvim_buf_get_lines(0, offset_line_nr, offset_line_nr + 1, false)[1]
  #             local end_col = line_content and #line_content or 0
  #
  #             local fill_spaces_count = win_width - end_col
  #             local fill_spaces = string.rep(' ', math.max(0, fill_spaces_count))
  #
  #             -- Set the extmark with the proper end_col and virtual text
  #             vim.api.nvim_buf_set_extmark(0, ns_id, offset_line_nr, 0, {
  #               id = 1010+line_offset,
  #               end_line = offset_line_nr, -- Same line
  #               end_col = end_col, -- Ending column
  #               hl_group = hl_group,
  #               hl_eol = false,
  #               virt_text_win_col = end_col,
  #               virt_text = {{fill_spaces, hl_group}}
  #             })
  #           end
  #       end
  #   end
  #
  #   function modify_hl(ns, name, changes)
  #     local def = vim.api.nvim_get_hl(ns, { name = name, link = false })
  #     vim.api.nvim_set_hl(ns, name, vim.tbl_deep_extend("force", def, changes))
  #   end
  #
  #   for i, line_color in ipairs(level_color) do
  #       vim.api.nvim_set_hl(0, "OffsetCursorlineL"..i, {bg=line_color[2]})
  #       vim.api.nvim_create_autocmd({'CursorMoved', 'CursorMovedI'}, {
  #         pattern = '*',
  #         callback = fill_space_to_end_of_window(line_color[1], "OffsetCursorlineL"..i),
  #       })
  #
  #   end
  # '';
}
