{
  pkgs,
  helpers,
  ...
}: {
  plugins.obsidian = {
    enable = true;
    settings = {
      legacy_commands = false;
      workspaces = [
        {
          name = "vault";
          path = "~/vault";
        }
      ];
      attachments = {
        folder = "/";
      };
      note_id_func.__raw = ''
        function(title, path)
          -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
          -- In this case a note with the title 'My new note' will be given an ID that looks
          -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
          local suffix = ""
          if title ~= nil then
            -- If title is given, transform it into valid file name.
            suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
          else
            -- If title is nil, just add 4 random uppercase letters to the suffix.
            for _ = 1, 4 do
              suffix = suffix .. string.char(math.random(65, 90))
            end
          end
          return tostring(os.time()) .. "-" .. suffix
        end
      '';
    };
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>of";
      action = "<cmd>Obsidian quick_switch<cr>";
    }
    {
      mode = "n";
      key = "<leader>oF";
      action = ''<cmd>lua require("telescope.builtin").find_files({cwd="/home/jonboh/vault/"})<cr>'';
    }
    {
      mode = "n";
      key = "<leader>os";
      action = ''<cmd>lua require("telescope.builtin").live_grep({cwd="/home/jonboh/vault/"})<cr>'';
    }
    {
      mode = "n";
      key = "<leader>on";
      action = "<cmd>Obsidian new<cr>";
    }
    {
      mode = "n";
      key = "<leader>ob";
      action = "<cmd>Obsidian backlinks<cr>";
    }
    {
      mode = "n";
      key = "<leader>ch";
      action = "<cmd>Obsidian toggle_checkbox<cr>";
    }
  ];
  extraConfigLua = ''
    vault_root = "~/vault"
    local make_absolute_link = function(target)
      local obsidian = require("obsidian")
      if target:sub(1,1) == "/" then -- absolute path
        return target
      else -- path from vault
        return vault_root.."/"..target
      end
    end

    local obsidian = require("obsidian")
    vim.keymap.set("n", "gf", function()
      link = require("obsidian").util.cursor_link()
      if link then
        target = obsidian.util.parse_link(link)
        if target:sub(-4) == ".tex" then
            return "<cmd>e "..make_absolute_link(target).."<cr>"
        else
          local handle = io.popen("${pkgs.file}/bin/file '" .. make_absolute_link(target) .. "' | awk '{print $2}'")
          local result = handle:read("*a")
          handle:close()
          if (vim.trim(result):match("^directory$")) then
            return "<cmd>e "..target.."<cr>"
          else
            return "<cmd>Obsidian follow_link<CR>"
          end
        end
      else
        return "gf"
      end
    end, { noremap = false, expr = true })
  '';

  # modified from https://heitorpb.github.io/bla/format-tables-in-vim/
  extraConfigVim = ''
    command! -range TableFormat <line1>,<line2>!tr -s " " | column -t -s '|' -o '|'
  '';
}
