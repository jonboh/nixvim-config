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
        rev = "f23036c2bd3a07a032d16157e5c5b79de4dd74f6";
        sha256 = "sha256-cjTpnT/qzMFY5UKUWj7S4b8tKnPfDcdmMq0QkH0YWPY=";
      };
      # src = fetchTree {
      #   path = /home/jonboh/devel/neorg;
      #   type = "path";
      # };
    });
    modules = {
      "core.defaults".__empty = null;
      "core.concealer".__empty = null;
      "core.dirman".config = {
        workspaces = {
          vault = "~/vault";
          default = "~/vault";
        };
      };
      "core.ui.calendar".__empty = null;
      "core.integrations.telescope".__empty = null;
      "core.integrations.treesitter".__empty = null;
      "core.integrations.image".__empty = null;
      "core.latex.renderer" = {
        config = {
          conceal = true;
          render_on_enter = false;
          bounded_geometry = false;
          dpi = 300;
        };
      };

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
            '<localleader>j',
            ':Neorg journal today<CR>',
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
            '<localleader><C-l>',
            ':Neorg render-latex<CR>',
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
      action = ''<cmd>lua require('telescope.builtin').live_grep({ search_dirs = {'~/vault'}, path_display = {"tail"} })<cr>'';
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
