{
  plugins.telescope = {
    enable = true;
    extensions = {
      fzf-native.enable = true;
      file-browser = {
        enable = true;
        settings = {
          path = "%:p:h";
          hidden = true;
          follow_symlinks = true;
          hide_parent_dir = true;
          mappings = {
            i = {
              "<A-c>" = "require('telescope._extensions.file_browser.actions').create";
              "<S-CR>" = "require('telescope._extensions.file_browser.actions').create_from_prompt";
              "<A-r>" = "require('telescope._extensions.file_browser.actions').rename";
              "<A-m>" = "require('telescope._extensions.file_browser.actions').move";
              "<A-y>" = "require('telescope._extensions.file_browser.actions').copy";
              "<A-x>" = "require('telescope._extensions.file_browser.actions').remove";
              "<C-Left>" = "require('telescope._extensions.file_browser.actions').goto_parent_dir";
              "<C-w>" = "require('telescope._extensions.file_browser.actions').goto_cwd";
              "<C-t>" = "require('telescope._extensions.file_browser.actions').change_cwd";
              "<C-f>" = "require('telescope._extensions.file_browser.actions').toggle_browser";
              "<C-h>" = "require('telescope._extensions.file_browser.actions').toggle_hidden";
              "<C-s>" = "require('telescope._extensions.file_browser.actions').toggle_all";
              "<bs>" = "require('telescope._extensions.file_browser.actions').backspace";
            };
            n = {
              "c" = "require('telescope._extensions.file_browser.actions').create";
              "r" = "require('telescope._extensions.file_browser.actions').rename";
              "m" = "require('telescope._extensions.file_browser.actions').move";
              "y" = "require('telescope._extensions.file_browser.actions').copy";
              "x" = "require('telescope._extensions.file_browser.actions').remove";
              "<C-Left>" = "require('telescope._extensions.file_browser.actions').goto_parent_dir";
              "w" = "require('telescope._extensions.file_browser.actions').goto_cwd";
              "t" = "require('telescope._extensions.file_browser.actions').change_cwd";
              "f" = "require('telescope._extensions.file_browser.actions').toggle_browser";
              "h" = "require('telescope._extensions.file_browser.actions').toggle_hidden";
              "s" = "require('telescope._extensions.file_browser.actions').toggle_all";
            };
          };
        };
      };
    };
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>f";
      action = ''<cmd>lua require("telescope.builtin").find_files()<cr>'';
      options = {
        silent = true;
        desc = "Find files";
      };
    }
    {
      mode = "n";
      key = "<leader>s";
      action = ''<cmd>lua require("telescope.builtin").live_grep()<cr>'';
      options = {
        silent = true;
        desc = "Live grep";
      };
    }
    {
      mode = "n";
      key = "<leader>jf";
      action = ''<cmd>FindFilesGitCurrentBuffer<cr>'';
      options = {
        silent = true;
        desc = "Find files";
      };
    }
    {
      mode = "n";
      key = "<leader>js";
      action = ''<cmd>LiveGrepGitCurrentBuffer<cr>'';
      options = {
        silent = true;
        desc = "Live grep";
      };
    }
    {
      mode = "v";
      key = "<leader>s";
      action = ''"zy<cmd>exec "Telescope grep_string search=" . escape(@z, " ")<cr>'';
      options = {
        silent = true;
        desc = "Find selection";
      };
    }
    {
      mode = "n";
      key = "<leader>tw";
      action = ''
        <cmd>lua require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>")})<cr>'';
      options = {
        silent = true;
        desc = "Word grep";
      };
    }
    {
      mode = "n";
      key = "<leader>tt";
      action = ''<cmd>lua require("telescope.builtin").resume()<cr>'';
      options = {
        silent = true;
        desc = "Resume Telescope";
      };
    }
    {
      mode = "n";
      key = "<leader>tq";
      action = ''<cmd>lua require("telescope.builtin").quickfix()<cr>'';
      options = {
        silent = true;
        desc = "Telescope Quickfixlist";
      };
    }
    {
      mode = "n";
      key = "<leader>/";
      action = ''
        <cmd>lua require("telescope.builtin").current_buffer_fuzzy_find({ sorting_strategy="ascending", layout_config={prompt_position="top"}})<cr>'';
      options = {
        silent = true;
        desc = "Current buffer search";
      };
    }
    {
      mode = "n";
      key = "<leader>:";
      action = ''<cmd>lua require("telescope.builtin").commands()<cr>'';
      options = {
        silent = true;
        desc = "Telescope commands";
      };
    }
    {
      mode = "n";
      key = "<leader><C-r>";
      action = ''<cmd>lua require("telescope.builtin").command_history()<cr>'';
      options = {
        silent = true;
        desc = "Telescope commands";
      };
    }

    {
      mode = "n";
      key = "<leader>b";
      action = ''
        <cmd>lua require("telescope").extensions.file_browser.file_browser()<cr>'';
    }
  ];

  extraConfigLua = ''
    function generate_git_opts()
      local function is_git_repo()
        vim.fn.system("git rev-parse --is-inside-work-tree")

        return vim.v.shell_error == 0
      end

      local function get_git_root()
        local dot_git_path = vim.fn.finddir(".git", vim.fn.expand("%:p:h") .. ";")
        return vim.fn.fnamemodify(dot_git_path, ":h")
      end

      local opts = {}

      if is_git_repo() then
        opts = {
          cwd = get_git_root(),
        }
      end
      return opts
    end

    function live_grep_from_project_git_root()
      opts = generate_git_opts()
      require("telescope.builtin").live_grep(opts)
    end

    function find_files_from_project_git_root()
      opts = generate_git_opts()
      require("telescope.builtin").find_files(opts)
    end

    vim.api.nvim_create_user_command("LiveGrepGitCurrentBuffer", live_grep_from_project_git_root, { nargs = 0 })
    vim.api.nvim_create_user_command("FindFilesGitCurrentBuffer", find_files_from_project_git_root, { nargs = 0 })

  '';
}
