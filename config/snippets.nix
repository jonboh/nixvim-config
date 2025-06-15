{pkgs, ...}: {
  plugins.luasnip = {enable = true;};
  extraPlugins = [pkgs.vimPlugins.friendly-snippets];
  extraConfigLua = ''
    require("luasnip.loaders.from_vscode").lazy_load() -- following instructions from friendly-snippets.nvim
    local ls = require "luasnip"
    local types = require("luasnip.util.types")

    ls.config.set_config {
        -- This tells LuaSnip to keep around the last snippet. You can jump back into it if you move outside the selection
        history = true,

        -- This is for dynamic snippets, it updates the snippet as you type. I'm not sure I actually use this
        updateevents = "TextChanged,TextChangedI",

        -- Autosnippets
        -- enable_autosnippets = true;

        ext_opts = {
          [types.choiceNode] = {
              active = { virt_text = {{"<-", "Error"}}}
            }
          }
      }
    vim.keymap.set({"i", "s"}, "<C-h>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      end
    end, {silent=true})

    vim.keymap.set({"i", "s"}, "<C-,>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, {silent=true})
    vim.keymap.set({"i"}, "<CS-h>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, {silent=true})
    vim.keymap.set({"i"}, "<CS-,>", function()
      if ls.choice_active() then
        ls.change_choice(-1)
      end
    end, {silent=true})


    -- vim.keymap.set("n", "<leader><leader>s", "<cmd>source <mutabel snippets_location><cr>")

    local s = ls.snippet
    local sn = ls.snippet_node
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node
    local c = ls.choice_node
    local d = ls.dynamic_node
    local r = ls.restore_node

    -- ls.add_snippets("nix", {
    --   s("test_choice",{
    --   c(1, {
    --       t "CHOICE1",
    --       t "CHOICE2",
    --       t "CHOICE3",
    --     })
    --   })
    -- })
    ls.add_snippets("tex", {
      s("frame",
        {
          t{'\\begin{frame}', ""},
          i(0),
          t{"", '\\end{frame}', ""},
      })
    })

    ls.add_snippets("rust", {
      s('allowfreedom', t '#![allow(clippy::disallowed_names, unused_variables, dead_code)]'),

      s('clippypedantic', t '#![warn(clippy::all, clippy::pedantic)]'),

      s('print', {
        -- t {'println!("'}, i(1), t {' {:?}", '}, i(0), t {');'}}),
        t {'println!("'}, i(1), t {' {'}, i(0), t {':?}");'}}),

      s('struct',
      {
        t {'#[derive(Debug)]', ""},
        t {'struct '}, i(1), t {' {', ""},
          i(0),
        t {'}', ""},
      }),

      s('test',
      {
          t {'#[test]', ""},
          t {'fn '}, i(1), t {'() {', ""},
          t {'	assert'}, i(0), t {"", ""},
          t {'}'},
      }),

      s('testcfg',
      {
        t {'#[cfg(test)]', ""},
        t {'mod '}, i(1), t {' {', ""},
        t {'	#[test]', ""},
        t {'	fn '}, i(2), t {'() {', ""},
        t {'		assert'}, i(0), t {"", ""},
        t {'	}', ""},
        t {'}'},
      }),

      s('if',
      {
        t {'if '}, i(1), t {' {', ""},
         i(0),
        t {'}'},
      }),

      s('for',
      {
      t {'for '}, i(1), t {' in ' }, i(2), t {' {', ""},
            i(0),
      t {'}', ""},
      }),

      s('boxerror',
        {t {'Box<dyn std::error::Error>'}}
      ),

      s('resultboxerror',
        {t {'Result<'}, i(0), t{', Box<dyn std::error::Error>>'}}
      ),
    })

  '';
}
