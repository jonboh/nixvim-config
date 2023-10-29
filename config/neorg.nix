{ pkgs, ... }:
{
  plugins.neorg = {
    enable = true;
    modules = {
      "core.defaults".__empty = null;
      "core.concealer" = { __empty = null; };
      "core.dirman".config.workspaces = {
        vault = "~/doc/vault";
      };
      #"core.tempus".__empty = null; # waiting for nvim 0.10
      #"core.ui.calendar".__empty = null;
      #  "core.completion".config.engine = "nvim-cmp";
      "core.integrations.telescope" = { __empty = null; };

      "core.keybinds".config.hook.__raw = ''
        function(keybinds)
          --keybinds.unmap('norg', 'n', '<C-s>')

          keybinds.map(
            'norg',
            'n',
            '<localleader>o',
            ':Neorg return<CR>',
            {silent=true}
          )
          keybinds.map(
            'norg',
            'n',
            '<localleader>c',
            ':Neorg toggle-concealer<CR>',
            {silent=true}
          )
        end
      '';
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>o";
      action = "<cmd>Neorg workspace vault<cr>";
      options = {
        desc = "Open vault";
      };
    }
  ];

  extraPlugins = [
    pkgs.vimPlugins.neorg-telescope
  ];
  extraConfigLua = ''
    --local callme = function()
    --  print("hello")
    --  end

    --vim.callme = callme

    local neorg_callbacks = require("neorg.core.callbacks")

    neorg_callbacks.on_event("core.keybinds.events.enable_keybinds", function(_, keybinds)
        -- Map all the below keybinds only when the "norg" mode is active
        keybinds.map_event_to_mode("norg", {
            n = { -- Bind keys in normal mode
                { "<leader>of", "core.integrations.telescope.find_linkable" },
            },

            --i = { -- Bind in insert mode
              --  { "<C-l>", "core.integrations.telescope.insert_link" },
            --},
        }, {
            silent = true,
            noremap = true,
        })
    end)
  '';
}
