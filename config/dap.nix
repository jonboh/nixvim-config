{pkgs, ...}: {
  keymaps = [
    {
      mode = "n";
      key = "<F35>"; # "<C-F11>"
      action = ''<cmd>lua require("dap").terminate()<cr>'';
      options = {silent = true;};
    }
    {
      mode = "n";
      key = "<F4>";
      action = ''<cmd>lua require("dap").run_to_cursor()<cr>'';
      options = {silent = true;};
    }
    {
      mode = "v";
      key = "<F6>";
      action = ''<cmd>lua require("dapui").eval(vim.fn.expand("<cword>"))<cr>'';
      options = {silent = true;};
    }
    {
      mode = "n";
      key = "<F6>";
      action = ''<cmd>lua require("dapui").eval()<cr>'';
      options = {silent = true;};
    }
    {
      mode = "n";
      key = "<F5>";
      action = ''<cmd>lua require("dap").toggle_breakpoint()<cr>'';
      options = {silent = true;};
    }
    {
      mode = "n";
      key = "<F17>"; # <S-F10>
      action = ''
        <cmd>lua require("dap").set_breakpoint(vim.fn.input("Breakpoint condition:"))<cr>'';
      options = {silent = true;};
    }
    {
      mode = "n";
      key = "<F10>"; # <FLeft>
      action = ''<cmd>lua require("dap").continue()<cr>'';
      options = {silent = true;};
    }
    {
      mode = "n";
      key = "<F1>"; # <FDown>
      action = ''<cmd>lua require("dap").step_over()<cr>'';
      options = {silent = true;};
    }
    {
      mode = "n";
      key = "<F2>"; # <FUp>
      action = ''<cmd>lua require("dap").step_out()<cr>'';
      options = {silent = true;};
    }
    {
      mode = "n";
      key = "<F3>"; # <FRight>
      action = ''<cmd>lua require("dap").step_into()<cr>'';
      options = {silent = true;};
    }
    {
      mode = "n";
      key = "<F4>"; # FPinky
      action = ''<cmd>lua require("dap").pause()<cr>'';
      options = {silent = true;};
    }
    {
      mode = "n";
      key = "<F49>"; # <A-FDown>
      action = ''<cmd>lua require("dap").down()<cr>'';
      options = {silent = true;};
    }
    {
      mode = "n";
      key = "<F50>"; # <A-FUp>
      action = ''<cmd>lua require("dap").up()<cr>'';
      options = {silent = true;};
    }
    {
      mode = "n";
      key = "<F51>"; # <A-FRight>
      action = ''<cmd>lua require("dap").focus_frame()<cr>'';
      options = {silent = true;};
    }
    {
      mode = "n";
      key = "<F12>"; # FPinky-South
      action = ''
        <cmd>lua require("dapui").toggle(1)<cr><cmd>lua require("dapui").toggle(2)<cr>'';
      options = {silent = true;};
    }
  ];
  extraPlugins = [
    pkgs.vimPlugins.nvim-dap
    pkgs.vimPlugins.nvim-dap-ui
    pkgs.vimPlugins.nvim-dap-virtual-text
    pkgs.vimPlugins.nvim-dap-rr
    pkgs.vimPlugins.nvim-dap-python
  ];
  extraConfigLua = ''
        local dap = require('dap')
        local dapui = require("dapui")

        local vscode_extensions = "/run/current-system/sw/share/vscode/extensions/"
        local codelldb_path = vscode_extensions.."vadimcn.vscode-lldb/adapter/codelldb"
        local cpptools_path = vscode_extensions.."ms-vscode.cpptools/debugAdapters/bin/OpenDebugAD7"
        dap.adapters.codelldb = {
            type = 'server',
            port = "''${port}",
            executable = {
                command = codelldb_path,
                args = {"--port", "''${port}"},

                -- On windows you may have to uncomment this:
                -- detached = false,
            }
        }

        dap.adapters.cppdbg = {
            id = 'cppdbg',
            type = 'executable',
            command = cpptools_path,
        }


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
        -- dap.listeners.after.event_initialized["dapui_config"] = function()
        --   dapui.open()
        -- end
        -- dap.listeners.before.event_terminated["dapui_config"] = function()
        --   dapui.close()
        -- end
        --
        -- dap.listeners.before.event_exited["dapui_config"] = function()
        --   dapui.close()
        -- end

        require("nvim-dap-virtual-text").setup()


        -- Rust Configuration

        local has_telescope, telescope = pcall(require, "telescope")

        local find_program
        if has_telescope then
          local pickers = require("telescope.pickers")
          local finders = require("telescope.finders")
          local conf = require("telescope.config").values
          local actions = require("telescope.actions")
          local action_state = require("telescope.actions.state")

          find_program = function()
            return coroutine.create(function(coro)
              local opts = {}
              pickers
                .new(opts, {
                  prompt_title = "Path to executable",
                  finder = finders.new_oneshot_job(
                    { "fd", "--absolute-path", "--hidden", "--exclude", ".git", "--no-ignore", "--type", "x" },
                    {}
                  ),
                  sorter = conf.generic_sorter(opts),
                  attach_mappings = function(buffer_number)
                    actions.select_default:replace(function()
                      actions.close(buffer_number)
                      coroutine.resume(coro, action_state.get_selected_entry()[1])
                    end)
                    return true
                  end,
                })
                :find()
            end)
          end
        else
          find_program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end
        end


        function get_debugcmd()
          local debug_args_path = ".debug-cmd"
          local file = io.open(debug_args_path, "r")
          -- If the file doesn't exist, return an empty table
          if not file then
            return {}
          end
          -- Read the first line of the file
          local line = file:read("*line")
          file:close()
          -- If the line is nil or empty, return an empty table
          if not line or line == "" then
            return {}
          end
          -- Split the line by whitespace and return the parts as a table
          return cmd
        end

        function get_debugargs()
          local debug_args_path = ".debug-args"
          local file = io.open(debug_args_path, "r")
          -- If the file doesn't exist, return an empty table
          if not file then
            return {}
          end
          -- Read the first line of the file
          local line = file:read("*line")
          file:close()
          -- If the line is nil or empty, return an empty table
          if not line or line == "" then
            return {}
          end
          -- Split the line by whitespace and return the parts as a table
          local args = {}
          for arg in line:gmatch("%S+") do
            table.insert(args, arg)
          end
          return args
        end


        local dap = require("dap")

        local get_rust_gdb_path = function()
            local toolchain_location = string.gsub(vim.fn.system("rustc --print sysroot"), "\n", "")
            local rustgdb = toolchain_location.."/bin/rust-gdb"
            return rustgdb
        end

        local get_rust_lldb_path = function()
            local toolchain_location = string.gsub(vim.fn.system("rustc --print sysroot"), "\n", "")
            local rustlldb= toolchain_location.."/bin/rust-lldb"
            return rustlldb
        end

        require('dap').defaults.fallback.exception_breakpoints = {'uncaught', 'rust_panic'}
        dap.configurations.rust = {
        {
            name = "(lldb) Launch file (with .debug-args)",
            type = "codelldb",
            request = "launch",
            program = find_program,
            miDebuggerPath = get_rust_lldb_path,
            cwd = "''${workspaceFolder}",
            args = get_debugargs,
            stopOnEntry = false,
            showDisassembly = "never",
        },
        {
            name = "(gdb) Launch file (with .debug-args)",
            type = "cppdbg",
            request = "launch",
            program = find_program,
            miDebuggerPath = get_rust_gdb_path,
            cwd= vim.fn.getcwd,
            args = get_debugargs,
            stopAtEntry = false,
            showDisassembly = "never",
        },
        {
            name = "(lldb) Launch .debug-cmd with .debug-args",
            type = "codelldb",
            request = "launch",
            program = get_debugcmd,
            miDebuggerPath = get_rust_lldb_path,
            cwd = "''${workspaceFolder}",
            args = get_debugargs,
            stopOnEntry = false,
            showDisassembly = "never",
        },
        {
            name = "(gdb) Launch .debug-cmd with .debug-args",
            type = "cppdbg",
            request = "launch",
            program = get_debugcmd,
            miDebuggerPath = get_rust_gdb_path,
            cwd= vim.fn.getcwd,
            args = get_debugargs,
            stopAtEntry = false,
            showDisassembly = "never",
        },
        {
            -- If you get an "Operation not permitted" error using this, try disabling YAMA:
            --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
            name = "(gdb) Attach to process",
            type = "cppdbg",
            request = "attach",
            program = find_program, -- unfortunately it seems this is needed due to the debug adapter impl: https://github.com/mfussenegger/nvim-dap/issues/881
            processId = require('dap.utils').pick_process,
            miDebuggerPath = get_rust_gdb_path,
        },

    }
        dap.configurations.cpp = {
        {
            name = "(lldb) Launch file (with .debug-args)",
            type = "codelldb",
            request = "launch",
            program = find_program,
            cwd = "''${workspaceFolder}",
            args = get_debugargs,
            stopOnEntry = false,
            showDisassembly = "never",
        },
        {
            name = "(gdb) Launch file (with .debug-args)",
            type = "cppdbg",
            request = "launch",
            program = find_program,
            cwd= vim.fn.getcwd,
            args = get_debugargs,
            stopAtEntry = false,
            showDisassembly = "never",
        },
        {
            name = "(lldb) Launch .debug-cmd with .debug-args",
            type = "codelldb",
            request = "launch",
            program = get_debugcmd,
            cwd = "''${workspaceFolder}",
            args = get_debugargs,
            stopOnEntry = false,
            showDisassembly = "never",
        },
        {
            name = "(gdb) Launch file (with .debug-args)",
            type = "cppdbg",
            request = "launch",
            program = get_debugcmd,
            cwd= vim.fn.getcwd,
            args = get_debugargs,
            stopAtEntry = false,
            showDisassembly = "never",
        },
        {
            -- If you get an "Operation not permitted" error using this, try disabling YAMA:
            --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
            name = "(gdb) Attach to process",
            type = "cppdbg",
            request = "attach",
            program = find_program, -- unfortunately it seems this is needed due to the debug adapter impl: https://github.com/mfussenegger/nvim-dap/issues/881
            processId = require('dap.utils').pick_process,
        },
    }
      dap.configurations.c = dap.configurations.cpp

      local rr_dap = require("nvim-dap-rr")
      rr_dap.setup({
          mappings = {
              continue = "<F10>", -- FRight
              step_over = "<F1>", -- FDown
              step_out = "<F2>", -- FUp
              step_into = "<F3>", -- FRight
              reverse_continue = "<F22>", -- <S-FLeft>
              reverse_step_over = "<F13>", -- <S-FDown>
              reverse_step_out = "<F14>", -- <S-FUp>
              reverse_step_into = "<F15>", -- <S-FRight>
              step_over_i = "<F25>", -- <C-FDown>
              step_out_i = "<F26>", -- <C-FUp>
              step_into_i = "<F27>", -- <C-FRight>
              reverse_step_over_i = "<F37>", -- <SC-FDown>
              reverse_step_out_i = "<F38>", -- <SC-FUp>
              reverse_step_into_i = "<F39>", -- <SC-FRight>
          }
      })
      table.insert(dap.configurations.rust, rr_dap.get_rust_config())
      table.insert(dap.configurations.cpp, rr_dap.get_config())

    require('dap-python').setup('python')
    table.insert(require('dap').configurations.python, {
      type = 'python',
      request = 'launch',
      name = 'Launch current file with .debug-args',
      program =  "''${file}",
      args = get_debugargs,
      -- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
    })

    vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = '#993939', bg = '#31353f' })
    vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = '#61afef', bg = '#31353f' })
    vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = '#98c379', bg = '#31353f' })

    vim.fn.sign_define('DapBreakpoint', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointCondition', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint' })
    vim.fn.sign_define('DapBreakpointRejected', { text='', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl= 'DapBreakpoint' })
    vim.fn.sign_define('DapLogPoint', { text='', texthl='DapLogPoint', linehl='DapLogPoint', numhl= 'DapLogPoint' })
    vim.fn.sign_define('DapStopped', { text='', texthl='DapStopped', linehl='DapStopped', numhl= 'DapStopped' })

  '';
}
