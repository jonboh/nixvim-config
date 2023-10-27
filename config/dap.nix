{ pkgs, ... }:
{
  # TODO: add nvim-dap-rr
  # TODO: add server configuration for cpptools and codelldb for cpp and rust
  # TODO: add python configuration
  keymaps = [
    {
      mode = "n";
      key = "<F36>"; # "<C-F12>"
      action = ''<cmd>lua require("dap").terminate()<cr>'';
      options = {
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<F2>";
      action = ''<cmd>lua require("dap").run_to_cursor()<cr>'';
      options = {
        silent = true;
      };
    }
    {
      mode = "v";
      key = "<F5>";
      action = ''<cmd>lua require("dapui").eval(vim.fn.expand("<cword>"))<cr>'';
      options = {
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<F5>";
      action = ''<cmd>lua require("dapui").eval()<cr>'';
      options = {
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<F6>";
      action = ''<cmd>lua require("dap").toggle_breakpoint()<cr>'';
      options = {
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<F7>";
      action = ''<cmd>lua require("dap").continue()<cr>'';
      options = {
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<F8>";
      action = ''<cmd>lua require("dap").step_over()<cr>'';
      options = {
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<F9>";
      action = ''<cmd>lua require("dap").step_out()<cr>'';
      options = {
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<F10>";
      action = ''<cmd>lua require("dap").step_into()<cr>'';
      options = {
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<F11>";
      action = ''<cmd>lua require("dap").pause()<cr>'';
      options = {
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<F56>"; # <A-F8>
      action = ''<cmd>lua require("dap").down()<cr>'';
      options = {
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<F57>"; # <A-F9>
      action = ''<cmd>lua require("dap").up()<cr>'';
      options = {
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<F18>"; # <A-F9>
      action = ''<cmd>lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition:"))<cr>'';
      options = {
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<F12>";
      action = ''<cmd>lua require("dapui").toggle(1)<cr><cmd>lua require("dapui").toggle(2)<cr>'';
      options = {
        silent = true;
      };
    }
  ];
  extraPlugins = [
    pkgs.vimPlugins.nvim-dap
    pkgs.vimPlugins.nvim-dap-ui
    pkgs.vimPlugins.nvim-dap-virtual-text
  ];
  extraConfigLua = ''
    local dap = require('dap')
    local dapui = require("dapui")
    dapui.setup({
      icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
      mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "r",
        toggle = "t",
      },
      -- Expand lines larger than the window
      -- Requires >= 0.7
      expand_lines = vim.fn.has("nvim-0.7"),
      -- Layouts define sections of the screen to place windows.
      -- The position can be "left", "right", "top" or "bottom".
      -- The size specifies the height/width depending on position. It can be an Int
      -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
      -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
      -- Elements are the elements shown in the layout (in order).
      -- Layouts are opened in order so that earlier layouts take priority in window sizing.
      layouts = {
        {
          elements = {
          -- Elements can be strings or table with id and size keys.
            "watches",
            "breakpoints",
            "stacks",
            { id = "scopes", size = 0.25 },
          },
          size = 40, -- 40 columns
          position = "left",
        },
        {
          elements = {
            "repl",
            "console",
          },
          size = 0.25, -- 25% of total lines
          position = "bottom",
        },
      },
      floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
          close = { "q", "<Esc>" },
        },
      },
      windows = { indent = 1 },
      render = {
        max_type_length = nil, -- Can be integer or nil.
        max_value_lines = 100, -- Can be integer or nil.
      }
    })


    -- Open/Close dapui with debugger session
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end

    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end

    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    require("nvim-dap-virtual-text").setup()
  '';

}
