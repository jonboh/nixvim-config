{
  pkgs,
  lib,
  ...
}: {
  plugins.snacks = {
    package = pkgs.callPackage ../plugins/snacks.nix {};
    enable = true;
    settings = {
      bigfile.enable = true;
      input.enable = true;
      picker.enable = true;
      notifier.enable = true;
      terminal.enable = true;
      image = {
        enable = true;
        resolve.__raw = ''
          function(path, src)
            local api = require "obsidian.api"
            if api.path_is_note(path) then
              return api.resolve_attachment_path(src)
            end
          end'';

        doc = {
          inline = true;
          float = true;
        };

        math = {
          enabled = true;
          latex = {
            font_size = "large";
            packages = ["amsmath" "amssymb" "amsfonts" "amscd" "mathtools"];
          };
        };
      };
    };
  };
  extraPackages = [pkgs.ghostscript pkgs.imagemagick pkgs.mermaid-cli]; # these are for snacks.image

  userCommands = {
    Notifications = {
      command.__raw = ''Snacks.notifier.show_history'';
    };
    ClearImages = {
      command.__raw = ''
        function()
          vim.fn.system("rm -rf " .. vim.env.HOME .. "/.cache/nvim/snacks/image")
          Snacks.image.image:clear()
          Snacks.image.placement.clean()
        end
      '';
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "z=";
      action = "<cmd>lua Snacks.picker.spelling()<cr>";
    }
  ];

  extraConfigLua = ''
    -- Create the ToggleImages command
    vim.api.nvim_create_user_command('ToggleImages', function()
      Snacks.image.image:toggle()
      local status = Snacks.image.image:is_enabled() and "Enabled" or "Disabled"
      vim.notify("Snacks.image " .. status)
    end, { desc = 'Toggle Snacks.image on/off' })
  '';
}
