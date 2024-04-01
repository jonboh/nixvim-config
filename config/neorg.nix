{
  pkgs,
  helpers,
  ...
}: {
  plugins.neorg = {
    enable = true;
    # package = pkgs.vimExtraPlugins.neorg; # NOTE: for nightly
    package = pkgs.vimPlugins.neorg.overrideAttrs (oldAttrs: {
      src = pkgs.fetchFromGitHub {
        owner = "jonboh";
        repo = "neorg";
        rev = "bd46cafb2ef1af8e47146b3e9a5dae607806f1f7";
        sha256 = "sha256-jXkjJ6P5LFErtkzbXkOKfO70T9ZPfJ11BeTqYAhomoA=";
      };
      # src = fetchTree {
      #   path = /home/jonboh/devel/neorg;
      #   # narHash = "sha256-LnPyjyegqU22rOhi5FhWB3JIemCpawPwsjr4piT++Vw=";
      #   type = "path";
      # };
    });
    modules = {
      "core.defaults".__empty = null;
      "core.concealer" = {__empty = null;};
      "core.dirman".config.workspaces = {vault = "~/doc/vault";};
      #"core.tempus".__empty = null; # waiting for nvim 0.10
      #"core.ui.calendar".__empty = null;
      #  "core.completion".config.engine = "nvim-cmp";
      "core.integrations.telescope" = {__empty = null;};
      "core.integrations.treesitter" = {__empty = null;};
      "core.integrations.image" = {__empty = null;};
      # "core.export" = {__empty = null;};
      # "core.export.markdown" = {__empty = null;};
      "core.latex.renderer" = {
        config = {
          conceal = true;
          render_on_enter = true;
          dpi = 200;
        };
      };
      # "core.integrations.renderer" = { __empty = null; };

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
          keybinds.map(
            'norg',
            'n',
            '<localleader>f',
            ':Telescope neorg find_norg_files<CR>',
            {silent=true}
          )
          keybinds.map(
            'norg',
            'n',
            '<localleader>s',
            ':Telescope neorg find_linkable<CR>',
            {silent=true}
          )
          keybinds.map(
            'norg',
            'n',
            '<localleader>lf',
            ':Telescope neorg insert_file_link<CR>',
            {silent=true}
          )
          keybinds.map(
            'norg',
            'n',
            '<localleader>ls',
            ':Telescope neorg insert_link<CR>',
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
      options = {desc = "Open vault";};
    }
    {
      mode = "n";
      key = "<leader>hs";
      action = ''<cmd>lua require('telescope.builtin').live_grep({ search_dirs = {'~/doc/vault'}, path_display = {"tail"} })<cr>'';
      options = {desc = "Live grep over vault";};
    }
  ];

  extraPlugins = [pkgs.vimPlugins.neorg-telescope];
  extraConfigLua = ''
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

  extraConfigVim = ''
    function! OpenNeorgHeader(file, header)
      " Escape the header for use in a Vim search pattern
      let escaped_header = escape(a:header, '\/.*$^~[]')
      " Open the file
      execute 'edit' a:file
      " Search for the header
      " Go to the top of the file
      execute 'normal! gg'
      execute 'normal! /' . escaped_header . "\<CR>"
    endfunction
  '';
}
