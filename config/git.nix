{
  plugins.fugitive.enable = true;

  plugins.gitsigns = {enable = true;};

  keymaps = [
    {
      mode = "n";
      key = "jp";
      action = "<cmd>diffput<cr>";
    }
    {
      mode = "n";
      key = "jg";
      action = "<cmd>diffget<cr>";
    }
    # for 3 way diff
    {
      mode = "n";
      key = "j<Left>";
      action = "<cmd>diffget //2<cr>";
    }
    {
      mode = "n";
      key = "j<Right>";
      action = "<cmd>diffget //3<cr>";
    }

    {
      mode = "n";
      key = "jd";
      action = "<cmd>Gvdiffsplit!<cr>";
      options = {
        desc = "Diff againt HEAD";
      };
    }
    {
      mode = "n";
      key = "jD";
      action = "<cmd>lua vim.cmd(\"Gvdiffsplit! HEAD~\"..vim.api.nvim_get_vvar('count'))<cr>";
      options = {
        desc = "Diff againt HEAD~<count>";
      };
    }
  ];

  extraConfigLua = ''
    require('gitsigns').setup{
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', 'j<Down>', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, {expr=true})

        map('n', 'j<Up>', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, {expr=true})

        -- Actions
        map('n', 'js', gs.stage_hunk)
        map('n', 'jr', gs.reset_hunk)
        map('v', 'js', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        map('v', 'jr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
        map('n', 'jS', gs.stage_buffer)
        map('n', 'ju', gs.undo_stage_hunk)
        map('n', 'jR', gs.reset_buffer)
        map('n', 'jv', gs.preview_hunk)
        map('n', 'jb', function() gs.blame_line{full=true} end)
        map('n', 'jB', gs.toggle_current_line_blame)

        -- Text object
        -- map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      end
    }
  '';
}
