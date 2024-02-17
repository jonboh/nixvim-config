{ pkgs, ... }: {
  config = {
    options.completeopt = [ "menu" "menuone" "noselect" ];

    plugins = {
      luasnip.enable = true;

      lspkind = {
        enable = true;

        cmp = {
          enable = true;
          menu = {
            nvim_lsp = "[LSP]";
            nvim_lua = "[api]";
            path = "[path]";
            luasnip = "[snip]";
            buffer = "[buffer]";
            neorg = "[neorg]";
          };
        };
      };

      nvim-cmp = {
        enable = true;

        snippet.expand = "luasnip";

        mapping = {
          "<C-u>" = "cmp.mapping.scroll_docs(-4)";
          "<C-d>" = "cmp.mapping.scroll_docs(4)";
          "<C-e>" = {
            action = ''
              cmp.mapping(function()
                          if cmp.visible() then
                              cmp.select_next_item({behavior = cmp.SelectBehavior.Select})
                          else
                              cmp.complete()
                          end
                      end)'';
          };
          "<C-n>" = {
            action = ''
              cmp.mapping(function()
                          if cmp.visible() then
                              cmp.select_prev_item({behavior = cmp.SelectBehavior.Select})
                          else
                              cmp.complete()
                          end
                      end)'';
          };
          "<C-a>" = "cmp.mapping.confirm({ select = true })";
          # TODO: Add snippet completion functionality and doc window sizing
        };

        sources = [
          { name = "path"; }
          { name = "nvim_lsp"; }
          { name = "luasnip"; }
          {
            name = "buffer";
            # Words from other open buffers can also be suggested.
            option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
          }
          { name = "neorg"; }
        ];
      };
    };
    extraPlugins = [ pkgs.vimPlugins.cmp-cmdline ];
    extraConfigLua = ''
      local cmp = require("cmp")

      -- cmp.setup.filetype('gitcommit', {
      --     sources = cmp.config.sources({
      --         { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
      --     }, {
      --         { name = 'buffer' },
      --     })
      -- })

      -- NOTE: this needs to be in sync with the nix config -- wtf! why?!
      local completion_mappings = {
          ["<C-u>"] = cmp.mapping.scroll_docs(-4);
          ["<C-d>"] = cmp.mapping.scroll_docs(4);
          ["<C-e>"] = { c = function()
              if cmp.visible() then
                    cmp.select_next_item({behavior = cmp.SelectBehavior.Select})
                else
                    cmp.complete()
                end
            end},
          ["<C-n>"] = { c = function()
              if cmp.visible() then
                  cmp.select_prev_item({behavior = cmp.SelectBehavior.Select})
              else
                  cmp.complete()
              end
              end},
            ["<C-a>"] = { c = cmp.mapping.confirm({ select = true }) },
          }

      -- TODO: fix cmdline completion
      cmp.setup.cmdline({ '/', '?' }, {
          mapping = completion_mappings,
          sources = {
              { name = 'buffer' }
          }
      })

        cmp.setup.cmdline(':', {
            mapping = completion_mappings,
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                { name = 'cmdline' }
            })
        })

    '';
  };
}
