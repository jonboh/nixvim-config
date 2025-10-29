{
  pkgs,
  helpers,
  ...
}: let
  make_absolute_link_luafunc_definition = ''
    local make_absolute_link = function(target)
      local obsidian = require("obsidian")
      if target:sub(1,1) == "/" then -- absolute path
        return target
      else -- path from vault
        return obsidian.get_client():vault_root().filename.."/"..target
      end
    end
  '';
in {
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
      follow_url_func = ''
        function(url)
          vim.fn.jobstart({"xdg-open", url})
        end
      '';
      follow_img_func.__raw = ''
        function(url)
          ${make_absolute_link_luafunc_definition}
          vim.fn.jobstart({"xdg-open", make_absolute_link(url)})
        end
      '';
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
    ${make_absolute_link_luafunc_definition}

    local obsidian = require("obsidian")
    vim.keymap.set("n", "gf", function()
      if obsidian.util.cursor_on_markdown_link() then
        target = obsidian.util.parse_cursor_link()
        if target:sub(-4) == ".tex" then
            return "<cmd>e "..make_absolute_link(target).."<cr>"
        elseif target:sub(-4) == ".pdf" then
            vim.fn.jobstart({"xdg-open", make_absolute_link(target)})  -- linux
            return ""
        else
          local handle = io.popen("${pkgs.file}/bin/file '" .. target .. "' | awk '{print $2}'")
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
