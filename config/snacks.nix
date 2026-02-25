{pkgs, ...}: {
  plugins.snacks = {
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
          inline = false;
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
  };

  keymaps = [
    {
      mode = "n";
      key = "z=";
      action = "<cmd>lua Snacks.picker.spelling()<cr>";
    }
  ];
}
