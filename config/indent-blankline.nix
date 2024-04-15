{pkgs, ...}: {
  config = {
    options = {
      list = true;
      listchars = "space:⋅";
    };
    extraPlugins = [pkgs.vimPlugins.indent-blankline-nvim];
    extraConfigLua = ''
      local highlight = {
          "RainbowViolet",
      }
      local hooks = require "ibl.hooks"
      -- create the highlight groups in the highlight setup hook, so they are reset
      -- every time the colorscheme changes
      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
          vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
      end)

      vim.g.rainbow_delimiters = { highlight = highlight }
      require("ibl").setup { scope = { highlight = highlight } }

      hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)

    '';
  };
}
