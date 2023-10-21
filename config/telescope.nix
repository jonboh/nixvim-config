{
    plugins.telescope = {
        enable = true;
	extensions = {
		fzf-native.enable = true;
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
			desc = "Telescope Quickfixlist";
			};
	    }

    ];
}
