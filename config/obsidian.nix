{
  plugins.obsidian = {
    enable = true;
    settings = {
      workspaces = [
        {
          name = "vault";
          path = "~/vault";
        }
      ];
      follow_url_func = ''
        function(url)
          vim.fn.jobstart({"xdg-open", url})  -- linux
        end
      '';
      note_id_func = ''
        function(title)
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
      action = "<cmd>ObsidianQuickSwitch<cr>";
    }
    {
      mode = "n";
      key = "<leader>os";
      action = "<cmd>ObsidianSearch<cr>";
    }
    {
      mode = "n";
      key = "<leader>on";
      action = "<cmd>ObsidianNew<cr>";
    }
    {
      mode = "n";
      key = "<leader>ob";
      action = "<cmd>ObsidianBacklinks<cr>";
    }
  ];
  extraConfigLua = ''
    vim.keymap.set("n", "gf", function()
      if require("obsidian").util.cursor_on_markdown_link() then
        return "<cmd>ObsidianFollowLink<CR>"
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
