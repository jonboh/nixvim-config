{pkgs, ...}: {
  plugins.luasnip = {enable = true;};
  extraPlugins = [pkgs.vimPlugins.friendly-snippets];
  extraConfigLua = ''
        require("luasnip.loaders.from_vscode").lazy_load() -- following instructions from friendly-snippets.nvim
      local ls = require "luasnip"
    local types = require("luasnip.util.types")

    local s = ls.snippet
    local sn = ls.snippet_node
    local t = ls.text_node
    local i = ls.insert_node
    local f = ls.function_node
    local c = ls.choice_node
    local d = ls.dynamic_node
    local r = ls.restore_node

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
    })

  '';
}
