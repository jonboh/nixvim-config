{
  plugins.telescope = {
    enable = true;
    extensions = {
      fzf-native.enable = true;
    };
  };
  plugins.web-devicons.enable = true; # pretty icons
  keymaps = [
    {
      mode = "n";
      key = "<leader>f";
      action = ''<cmd>lua require("telescope.builtin").find_files({follow=true})<cr>'';
      options = {
        silent = true;
        desc = "Find files";
      };
    }
    {
      mode = "n";
      key = "<leader>F";
      action = ''<cmd>lua require("telescope.builtin").find_files({follow=true, hidden=true, no_ignore=true, no_ignore_parent=true})<cr>'';
      options = {
        silent = true;
        desc = "Find all files";
      };
    }
    {
      mode = "n";
      key = "<leader>rcf";
      action = ''<cmd>lua require("telescope.builtin").find_files({follow=true, cwd="/home/jonboh/.flakes/nixvim-config/"})<cr>'';
      options = {
        silent = true;
        desc = "Find files";
      };
    }
    {
      mode = "n";
      key = "<leader>rcs";
      action = ''<cmd>lua require("telescope.builtin").live_grep({cwd="/home/jonboh/.flakes/nixvim-config/"})<cr>'';
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
      action = ''<cmd>FindFilesGitOrNixStoreCurrentBuffer<cr>'';
      options = {
        silent = true;
        desc = "Find files in the current git directory or nix store path";
      };
    }
    {
      mode = "n";
      key = "<leader>js";
      action = ''<cmd>LiveGrepGitOrNixStoreCurrentBuffer<cr>'';
      options = {
        silent = true;
        desc = "Live grep in the current git directory or nix store path";
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
      key = "<leader>q";
      action = ''<cmd>Telescope quickfix<cr>'';
      options = {
        silent = true;
        desc = "Find files";
      };
    }
    {
      mode = "n";
      key = "<leader>Q";
      action = ''<cmd>Telescope quickfixhistory<cr>'';
      options = {
        silent = true;
        desc = "Find files";
      };
    }
  ];

  extraConfigLua = ''
    function generate_opts()

      local function get_git_root()
        local dot_git_path = vim.fn.finddir(".git", vim.fn.expand("%:p:h") .. ";")
        if dot_git_path ~= "" then
            return vim.fn.fnamemodify(dot_git_path, ":h")
        else
            return nil
        end
      end

      local function extract_nixstore_path(path)
        local pattern = '^(/nix/store/[a-z0-9]+%-[a-zA-Z0-9_.-]+)/'
        return string.match(path, pattern)
      end

      local opts = {}

      local gitroot = get_git_root()
      if gitroot then
          opts = {
            cwd = gitroot,
        }
        else
          nixstorepath = extract_nixstore_path(vim.api.nvim_buf_get_name(0))
          if nixstorepath  then
            if nixstorepath ~= "" then
              opts = {
                cwd = nixstorepath,
              }
            end
          end
        end
      return opts
    end

    function live_grep_from_project_git_root()
      opts = generate_opts()
      require("telescope.builtin").live_grep(opts)
    end

    function find_files_from_project_git_root()
      opts = generate_opts()
      require("telescope.builtin").find_files(opts)
    end

    vim.api.nvim_create_user_command("LiveGrepGitOrNixStoreCurrentBuffer", live_grep_from_project_git_root, { nargs = 0 })
    vim.api.nvim_create_user_command("FindFilesGitOrNixStoreCurrentBuffer", find_files_from_project_git_root, { nargs = 0 })
  '';
}
