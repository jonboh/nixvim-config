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
        vim.keymap.set('n', '<AC-Left>', require('smart-splits').resize_left)
        vim.keymap.set('n', '<AC-Down>', require('smart-splits').resize_down)
        vim.keymap.set('n', '<AC-Up>', require('smart-splits').resize_up)
        vim.keymap.set('n', '<AC-Right>', require('smart-splits').resize_right)
        -- moving between splits
        vim.keymap.set('n', '<A-Left>', require('smart-splits').move_cursor_left)
        vim.keymap.set('n', '<A-Down>', require('smart-splits').move_cursor_down)
        vim.keymap.set('n', '<A-Up>', require('smart-splits').move_cursor_up)
        vim.keymap.set('n', '<A-Right>', require('smart-splits').move_cursor_right)
        vim.keymap.set('t', '<A-Left>', require('smart-splits').move_cursor_left)
        vim.keymap.set('t', '<A-Down>', require('smart-splits').move_cursor_down)
        vim.keymap.set('t', '<A-Up>', require('smart-splits').move_cursor_up)
        vim.keymap.set('t', '<A-Right>', require('smart-splits').move_cursor_right)
        -- swapping buffers between windows
    --    vim.keymap.set('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
    --    vim.keymap.set('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
    --    vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
    --    vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right)
  '';
}
