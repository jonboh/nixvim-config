{pkgs, ...}: {
  extraPlugins = [
    # (pkgs.callPackage ../plugins/smart-splits.nix {})
    pkgs.vimPlugins.smart-splits-nvim
  ];

  extraConfigLua = ''
        require("smart-splits").setup({
            at_edge = "stop",
          })
        -- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
        vim.keymap.set('n', '<SC-Left>', require('smart-splits').resize_left)
        vim.keymap.set('n', '<SC-Down>', require('smart-splits').resize_down)
        vim.keymap.set('n', '<SC-Up>', require('smart-splits').resize_up)
        vim.keymap.set('n', '<SC-Right>', require('smart-splits').resize_right)
        vim.keymap.set('t', '<SC-Left>', require('smart-splits').resize_left)
        vim.keymap.set('t', '<SC-Down>', require('smart-splits').resize_down)
        vim.keymap.set('t', '<SC-Up>', require('smart-splits').resize_up)
        vim.keymap.set('t', '<SC-Right>', require('smart-splits').resize_right)
        -- moving between splits
        vim.keymap.set('n', '<S-Left>', require('smart-splits').move_cursor_left)
        vim.keymap.set('n', '<S-Down>', require('smart-splits').move_cursor_down)
        vim.keymap.set('n', '<S-Up>', require('smart-splits').move_cursor_up)
        vim.keymap.set('n', '<S-Right>', require('smart-splits').move_cursor_right)
        vim.keymap.set('t', '<S-Left>', require('smart-splits').move_cursor_left)
        vim.keymap.set('t', '<S-Down>', require('smart-splits').move_cursor_down)
        vim.keymap.set('t', '<S-Up>', require('smart-splits').move_cursor_up)
        vim.keymap.set('t', '<S-Right>', require('smart-splits').move_cursor_right)
        -- swapping buffers between windows
    --    vim.keymap.set('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
    --    vim.keymap.set('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
    --    vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
    --    vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right)
  '';
}
