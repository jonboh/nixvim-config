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
