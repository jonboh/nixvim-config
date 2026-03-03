{
  plugins = {
    treesitter = {
      enable = true;
      settings = {
        highlight = {
          enable = true;
          disable = ["csv"]; # csv highlight in nvim is better than treesitter
        };
      };
      nixvimInjections = true;
    };
    treesitter-context.enable = true;
    treesitter-textobjects = {
      enable = true;
      settings = {
        enable = true;
        lookahead = true;
      };
    };
  };
  extraConfigLua = ''
    -- MOVE
    -- Functions
    vim.keymap.set({ "n", "x", "o" }, "]f", function()
      require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "]F", function()
      require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "[f", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "[F", function()
      require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects")
    end)
    -- Classes
    vim.keymap.set({ "n", "x", "o" }, "]c", function()
      require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "]C", function()
      require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "[c", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "[C", function()
      require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
    end)
    -- Loops
    vim.keymap.set({ "n", "x", "o" }, "]o", function()
      require("nvim-treesitter-textobjects.move").goto_next_start("@loop.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "]O", function()
      require("nvim-treesitter-textobjects.move").goto_next_end("@loop.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "[o", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start("@loop.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "[O", function()
      require("nvim-treesitter-textobjects.move").goto_previous_end("@loop.outer", "textobjects")
    end)
    -- Block
    vim.keymap.set({ "n", "x", "o" }, "]b", function()
      require("nvim-treesitter-textobjects.move").goto_next_start("@local.scope", "locals")
    end)
    vim.keymap.set({ "n", "x", "o" }, "]B", function()
      require("nvim-treesitter-textobjects.move").goto_next_end("@local.scope", "locals")
    end)
    vim.keymap.set({ "n", "x", "o" }, "[b", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start("@local.scope", "locals")
    end)
    vim.keymap.set({ "n", "x", "o" }, "[B", function()
      require("nvim-treesitter-textobjects.move").goto_previous_end("@local.scope", "locals")
    end)
    -- Conditionals
    vim.keymap.set({ "n", "x", "o" }, "]u", function()
      require("nvim-treesitter-textobjects.move").goto_next_start("@conditional.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "]Y", function()
      require("nvim-treesitter-textobjects.move").goto_next_end("@conditional.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "[u", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start("@conditional.outer", "textobjects")
    end)
    vim.keymap.set({ "n", "x", "o" }, "[U", function()
      require("nvim-treesitter-textobjects.move").goto_previous_end("@conditional.outer", "textobjects")
    end)
    -- Folds
    vim.keymap.set({ "n", "x", "o" }, "]z", function()
      require("nvim-treesitter-textobjects.move").goto_next_start("@fold", "folds")
    end)
    vim.keymap.set({ "n", "x", "o" }, "[z", function()
      require("nvim-treesitter-textobjects.move").goto_previous_start("@fold", "folds")
    end)

    -- SWAP
    vim.keymap.set("n", "}p", function()
      require("nvim-treesitter-textobjects.swap").swap_next "@parameter.inner"
    end)
    vim.keymap.set("n", "{p", function()
      require("nvim-treesitter-textobjects.swap").swap_previous "@parameter.inner"
    end)

    -- SELECT
    -- You can use the capture groups defined in `textobjects.scm`
    vim.keymap.set({ "x", "o" }, "ip", function()
      require "nvim-treesitter-textobjects.select".select_textobject("@parameter.inner", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "ap", function()
      require "nvim-treesitter-textobjects.select".select_textobject("@parameter.outer", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "af", function()
      require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "if", function()
      require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "ac", function()
      require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
    end)
    vim.keymap.set({ "x", "o" }, "ic", function()
      require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
    end)
    -- You can also use captures from other query groups like `locals.scm`
    vim.keymap.set({ "x", "o" }, "ab", function()
      require "nvim-treesitter-textobjects.select".select_textobject("@local.scope", "locals")
    end)


    -- Make repeatable moves
    local ts_repeat_move = require "nvim-treesitter-textobjects.repeatable_move"

    -- Repeat movement with ; and ,
    -- ensure ; goes forward and , goes backward regardless of the last direction
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

    -- make builtin f, F, t, T also repeatable with ; and ,
    vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
    vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
  '';
}
