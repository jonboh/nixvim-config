{
 plugins.telescope = {
    enable = true;
    extensions = {
      fzf-native.enable = true;
      file_browser = {
        enable = true;
        path = "%:p:h";
      };
    };
  };
  keymaps = [
    # TODO: common configuration for telescope so that all by default go to top
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
      # TODO: fix this
      mode = "v";
      key = "<leader>s";
      action = ''"\"zy<cmd>exec "Telescope grep_string search=" . escape(@z, " ")<cr>""'';
      options = {
        silent = true;
        desc = "Find selection";
      };
    }
    {
      mode = "n";
      key = "<leader>tw";
      action = ''<cmd>lua require("telescope.builtin").grep_string({ search = vim.fn.expand("<cword>")})<cr>'';
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
      action = ''<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find({ sorting_strategy="ascending", layout_config={prompt_position="top"}})<cr>'';
      options = {
        silent = true;
        desc = "Current buffer search";
      };
    }
    # {
    #   mode = "n";
    #   key = "<leader>rc";
    #   action = ''<cmd>lua require("telescope.builtin")"}})<cr>'';
    #   options = {
    #     silent = true;
    #     desc = "Open rc folder";
    #   };
    # }
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
      action = ''<cmd>lua require("telescope").extensions.file_browser.file_browser()<cr>'';
    }
  ];
}
