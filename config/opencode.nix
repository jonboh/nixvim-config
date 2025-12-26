{pkgs, ...}: {
  extraPlugins = [
    # pkgs.vimPlugins.opencode-nvim
    (pkgs.callPackage ../plugins/opencode.nix {})
  ];
  extraConfigLua = ''
    vim.g.opencode_opts = {
      provider = {
        enabled = "snacks",
        snacks = {
          -- ...
        }
      }
    }
        -- Required for `opts.events.reload`.
    vim.o.autoread = true

    -- Recommended/example keymaps.
    vim.keymap.set({ "n", "v" }, "<C-g>n", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode" })
    vim.keymap.set({ "n", "v" }, "<C-g>e", function() require("opencode").select() end,                          { desc = "Execute opencode action…" })
    vim.keymap.set({ "n", "v", "t" }, "<C-g><C-g>", function() require("opencode").toggle() end,                          { desc = "Toggle opencode" })

    vim.keymap.set({ "v" }, "<leader>z",  function() return require("opencode").operator("@this ") end,        { expr = true, desc = "Add range to opencode" })

    vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,   { desc = "opencode half page up" })
    vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end, { desc = "opencode half page down" })
  '';
}
