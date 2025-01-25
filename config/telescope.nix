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
          respect_gitignore = false;
          follow_symlinks = true;
          hide_parent_dir = true;
          mappings = {
            i = {
              "<A-c>" = "require('telescope._extensions.file_browser.actions').create";
              "<S-CR>" = "require('telescope._extensions.file_browser.actions').create_from_prompt";
              "<A-r>" = "require('telescope._extensions.file_browser.actions').rename";
              "<A-m>" = "require('telescope._extensions.file_browser.actions').move";
              "<A-y>" = "require('telescope._extensions.file_browser.actions').copy";
              "<Up>" = "require('telescope.actions').move_selection_previous";
              "<Down>" = "require('telescope.actions').move_selection_next";
              "<Left>" = "require('telescope._extensions.file_browser.actions').goto_parent_dir";
              "<Right>" = "require('telescope.actions').select_default";
              "<C-w>" = "function() vim.cmd('normal vbd') end"; # this will make C-w behave as in readline
              "<C-t>" = "require('telescope._extensions.file_browser.actions').change_cwd";
              "<C-f>" = "require('telescope._extensions.file_browser.actions').toggle_browser";
              "<C-.>" = "require('telescope._extensions.file_browser.actions').toggle_hidden";
              "<C-s>" = "require('telescope._extensions.file_browser.actions').toggle_all";
              "<C-h>" = "false";
            };
            n = {
              "c" = "require('telescope._extensions.file_browser.actions').create";
              "r" = "require('telescope._extensions.file_browser.actions').rename";
              "m" = "require('telescope._extensions.file_browser.actions').move";
              "y" = "require('telescope._extensions.file_browser.actions').copy";
              "d" = ''
                function(prompt_bufnr)
                  local fb_utils = require "telescope._extensions.file_browser.utils"
                  local action_state = require "telescope.actions.state"
                  local current_picker = action_state.get_current_picker(prompt_bufnr)
                  local finder = current_picker.finder
                  local quiet = current_picker.finder.quiet
                  local trash_cmd = nil
                  if vim.fn.executable "trash" == 1 then
                    trash_cmd = "trash"
                  elseif vim.fn.executable "gio" == 1 then
                    trash_cmd = "gio"
                  end
                  if not trash_cmd then
                    fb_utils.notify("actions.trash", { msg = "Cannot locate a valid trash executable!", level = "WARN", quiet = quiet })
                    return
                  end
                  local selections = fb_utils.get_selected_files(prompt_bufnr, true)
                  if vim.tbl_isempty(selections) then
                    fb_utils.notify("actions.trash", { msg = "No selection to be trashed!", level = "WARN", quiet = quiet })
                    return
                  end

                  local files = vim.tbl_map(function(sel)
                    return sel.filename:sub(#sel:parent().filename + 2)
                  end, selections)

                  for _, sel in ipairs(selections) do
                    if sel:is_dir() then
                      local abs = sel:absolute()
                      local msg
                      if finder.files and Path:new(finder.path):parent():absolute() == abs then
                        msg = "Parent folder cannot be trashed!"
                      end
                      if not finder.files and Path:new(finder.cwd):absolute() == abs then
                        msg = "Current folder cannot be trashed!"
                      end
                      if msg then
                        fb_utils.notify("actions.trash", { msg = msg .. " Prematurely aborting.", level = "WARN", quiet = quiet })
                        return
                      end
                    end
                  end

                  local trashed = {}

                  local message = "Selections to be trashed: " .. table.concat(files, ", ")
                  fb_utils.notify("actions.trash", { msg = message, level = "INFO", quiet = quiet })
                  -- TODO fix default vim.ui.input and nvim-notify 'selections to be deleted' message
                  vim.ui.input({ prompt = "Trash selections [y/N]: " }, function(input)
                    vim.cmd [[ redraw ]] -- redraw to clear out vim.ui.prompt to avoid hit-enter prompt
                    if input and input:lower() == "y" then
                      for _, p in ipairs(selections) do
                        local is_dir = p:is_dir()
                        local cmd = nil
                        if trash_cmd == "gio" then
                          cmd = { "gio", "trash", "--", p:absolute() }
                        else
                          cmd = { trash_cmd, "--", p:absolute() }
                                  end
                        vim.fn.system(cmd)
                        if vim.v.shell_error == 0 then
                          table.insert(trashed, p.filename:sub(#p:parent().filename + 2))
                          -- clean up opened buffers
                          if not is_dir then
                            fb_utils.delete_buf(p:absolute())
                          else
                            fb_utils.delete_dir_buf(p:absolute())
                          end
                        else
                          local msg = "Command failed: " .. table.concat(cmd, " ")
                          fb_utils.notify("actions.trash", { msg = msg, level = "WARN", quiet = quiet })
                        end
                      end
                      local msg = nil
                      if next(trashed) then
                        msg = "Trashed: " .. table.concat(trashed, ", ")
                      else
                        msg = "No selections were successfully trashed"
                      end
                      fb_utils.notify("actions.trash", { msg = msg, level = "INFO", quiet = quiet })
                      current_picker:refresh(current_picker.finder)
                    else
                      fb_utils.notify("actions.trash", { msg = "Trashing selections aborted!", level = "INFO", quiet = quiet })
                    end
                  end)
                end
              '';
              "<Up>" = "require('telescope.actions').move_selection_previous";
              "<Down>" = "require('telescope.actions').move_selection_next";
              "<Left>" = "require('telescope._extensions.file_browser.actions').goto_parent_dir";
              "<Right>" = "require('telescope.actions').select_default";
              # "w" = "require('telescope._extensions.file_browser.actions').goto_cwd";
              "t" = "require('telescope._extensions.file_browser.actions').change_cwd";
              "f" = "require('telescope._extensions.file_browser.actions').toggle_browser";
              "." = "require('telescope._extensions.file_browser.actions').toggle_hidden";
              "s" = "require('telescope._extensions.file_browser.actions').toggle_all";
              "h" = "false";
            };
          };
        };
      };
    };
  };
  plugins.web-devicons.enable = true; # pretty icons
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
      key = "<leader>rcf";
      action = ''<cmd>lua require("telescope.builtin").find_files({cwd="/home/jonboh/.flakes/nixvim-config/"})<cr>'';
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
      key = "<leader>b";
      action = ''
        <cmd>lua require("telescope").extensions.file_browser.file_browser()<cr>'';
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
