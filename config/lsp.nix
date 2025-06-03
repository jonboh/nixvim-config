{pkgs, ...}: let
  extraCapabilities = ''
    -- for ufo-nvim
    capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true
    }
  '';
  # TODO: make a function+mapping to choose TodoComments keyword
  onAttach = ''
    local keymaps = {
      {
        mode = "n",
        key = "h<Space>",
        action = "<cmd>lua vim.diagnostic.setqflist()<cr><cmd>cfirst<cr>zzzv",
        options = {
          silent = true,
          desc = "Load LSP Diagnostics to qf",
        },
      },
      {
        mode = "n",
        key = "h1",
        action = "<cmd>TodoQuickFix keywords=TODO<cr>",
        options = {
          silent = true,
          desc = "Load TODO to qf",
        },
      },
      {
        mode = "n",
        key = "h2",
        action = "<cmd>TodoQuickFix keywords=FIX<cr>",
        options = {
          silent = true,
          desc = "Load FIX to qf",
        },
      },
      {
        mode = "n",
        key = "h0",
        action = "<cmd>TodoQuickFix<cr>",
        options = {
          silent = true,
          desc = "Load all TodoComments to qf",
        },
      },
      {
        mode = "n",
        key = "h<C-Space>",
        action = "<cmd>BaconLoad<cr><cmd>copen<cr><cmd>cfirst<cr>zzzv",
        options = {
          silent = true,
          desc = "Load Bacon locations to qf",
        },
      },
      {
        mode = "n",
        key = "hd",
        action = "<cmd>lua vim.lsp.buf.definition()<cr>",
        options = {
          silent = true,
          desc = "Go to LSP definition",
        },
      },
      {
        mode = "n",
        key = "hD",
        action = "<cmd>lua vim.lsp.buf.declaration()<cr>",
        options = {
          silent = true,
          desc = "Go to LSP declaration",
        },
      },
      {
        mode = "n",
        key = "hi",
        action = "<cmd>lua vim.lsp.buf.implementation()<cr>",
        options = {
          silent = true,
          desc = "Go to LSP implementation",
        },
      },
      {
        mode = "n",
        key = "ht",
        action = "<cmd>lua vim.lsp.buf.type_definition()<cr>",
        options = {
          silent = true,
          desc = "Go to LSP type definition",
        },
      },
      {
        mode = "n",
        key = "hr",
        action = "<cmd>lua vim.lsp.buf.references()<cr>",
        options = {
          silent = true,
          desc = "Go to LSP references",
        },
      },
      {
        mode = "n",
        key = "<C-k>",
        action = "<cmd>lua vim.lsp.buf.signature_help()<cr>",
        options = {
          silent = true,
          desc = "Signature Help",
        },
      },
      {
        mode = "i",
        key = "<C-k>",
        action = "<cmd>lua vim.lsp.buf.signature_help()<cr>",
        options = {
          silent = true,
          desc = "Signature Help",
        },
      },
      {
        mode = "n",
        key = "K",
        action = "<cmd>lua vim.lsp.buf.hover()<cr>",
        options = {
          silent = true,
          desc = "Open hover menu",
        },
      },
      {
        mode = "n",
        key = "hn",
        action = "<cmd>lua vim.lsp.buf.rename()<cr>",
        options = {
          silent = true,
          desc = "Rename symbol",
        },
      },
      {
        mode = "n",
        key = "ha",
        action = "<cmd>lua vim.lsp.buf.code_action()<cr>",
        options = {
          silent = true,
          desc = "Open code actions",
        },
      },
      {
        mode = "n",
        key = "he",
        action = "<cmd>lua vim.diagnostic.open_float()<cr>",
        options = {
          silent = true,
          desc = "Open diagnostic float",
        },
      },
      {
        mode = "n",
        key = "]e",
        action = "<cmd>lua vim.diagnostic.goto_next()<cr>",
        options = {
          silent = true,
          desc = "Go to next diagnostic",
        },
      },
      {
        mode = "n",
        key = "[e",
        action = "<cmd>lua vim.diagnostic.goto_prev()<cr>",
        options = {
          silent = true,
          desc = "Go to previous diagnostic",
        },
      },
      {
        mode = "n",
        key = ">e",
        action = "<cmd>lua vim.diagnostic.goto_next()<cr>",
        options = {
          silent = true,
          desc = "Go to next diagnostic",
        },
      },
      {
        mode = "n",
        key = "<e",
        action = "<cmd>lua vim.diagnostic.goto_prev()<cr>",
        options = {
          silent = true,
          desc = "Go to previous diagnostic",
        },
      },
      {
        mode = "n",
        key = "hs",
        action = "<cmd>Telescope lsp_workspace_symbols<cr>",
        options = {
          silent = true,
          desc = "Telescope workspace symbols",
        },
      },
    }
    for _, map in ipairs(keymaps) do
      map.options["buffer"] = bufnr
      vim.keymap.set(map.mode, map.key, map.action, map.options)
    end
  '';
in {
  plugins = {
    lsp = {
      enable = true;
      servers = {
        lua_ls.enable = true;
        nil_ls.enable = true;
        # ltex.enable = true; # throws an error about Khmer and Japanese missing common word files
        texlab.enable = true;
        terraformls.enable = true;
        marksman.enable = true;
        hls = {
          enable = true;
          installGhc = false;
        };
        julials = {
          # NOTE: needs to be installed manually
          # `julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'`
          enable = true;
          package = null;
        };
        clangd = {
          enable = true;
          filetypes = ["c" "cpp" "h" "hpp" "cuda"];
        };
      };
      inherit onAttach;
      capabilities = extraCapabilities;
    };

    lspkind.enable = true;

    rustaceanvim = {
      enable = true;
      settings = {
        rustAnalyzerPackage = null;
        server = {
          on_attach = ''function() ${onAttach} end'';
        };
        # NOTE: latest versions are able to infer adapter from PATH lldb
        # dap = {
        #   # NOTE: used to run RustLsp debuggables
        #   adapter = ''
        #     {
        #       type = 'server',
        #       port = "''${port}",
        #       executable = {
        #           command = "/run/current-system/sw/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb",
        #           args = {"--port", "''${port}"},
        #       }
        #     }
        #   '';
        # };
      };
    };
  };
  extraConfigLua = ''
    -- copy of __lspCapabilities from nixvim, which is not visible in extraConfigLua
    local lspCapabilities = function()
      capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
      ${extraCapabilities}
      return capabilities
    end

    require'lspconfig'.protols.setup{
      on_attach = function(client, bufnr)
          ${onAttach}
        end,
      capabilities = lspCapabilities()
      }
    require('lspconfig').ruff.setup {
      on_attach = function(client, bufnr)
          ${onAttach}
        end,
      capabilities = lspCapabilities()
      }
    require('lspconfig').pyright.setup {
      on_attach = function(client, bufnr)
          ${onAttach}
        end,
      capabilities = lspCapabilities()
      }
    require'lspconfig'.jsonnet_ls.setup {
      on_attach = function(client, bufnr)
          ${onAttach}
        end,
      capabilities = lspCapabilities()
      }
    vim.api.nvim_create_user_command("LspFormat", vim.lsp.buf.format, {})
  '';

  extraPlugins = [(pkgs.callPackage ../plugins/nvim-bacon.nix {})];
  keymaps = [
    {
      mode = "n";
      key = "hL";
      action = "<cmd>lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<cr>";
      options = {desc = "Toggle inlay_hints";};
    }
  ];
}
