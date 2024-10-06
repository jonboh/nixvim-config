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
}
