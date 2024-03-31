{pkgs, ...}: {
  plugins.image = {
    enable = true;
    # package = pkgs.vimPlugins.image-nvim;
    package = pkgs.vimPlugins.image-nvim.overrideAttrs (oldAttrs: {
      src = pkgs.fetchFromGitHub {
        owner = "3rd";
        repo = "image.nvim";
        rev = "a0b756d589c1623ebbfe344666e6d7c49bdc9d71";
        sha256 = "sha256-4xsyVDZOFidvLqwfWRB7BPMOejWk3/uhsnUsCNG/hpU=";
      };
      # src = fetchTree {
      #   path = /home/jonboh/devel/image.nvim;
      #   narHash = "sha256-oKLFLUTuTkQ4dJ7GemdytkJ+RQcT0C0XBzcvX//PxE8=";
      #   type = "path";
      # };
    });

    # integrations.clearInInsertMode = true;
    # windowOverlapClearEnabled = true;
    # windowOverlapClearFtIgnore = ["cmp_menu" "cmp_docs" ""];
  };

  extraConfigLua = ''
    vim.api.nvim_create_user_command("ImageClear", function(args)
      local img = require("image")
      local images = img.get_images()
      for i, image in pairs(images) do
        img.clear(image.id)
      end
    end,
    { desc="Clear Images" }
    )

    vim.api.nvim_create_user_command("ImageRender", function(args)
      local img = require("image")
      local images = img.get_images()
      for i, image in pairs(images) do
        img.render(image.id)
      end
    end,
    { desc="Render Images" })

    vim.api.nvim_create_user_command("ImageRefresh", function(args)
      local img = require("image")
      local images = img.get_images()
      for i, image in pairs(images) do
        img.clear(image.id)
      end
      local images = img.get_images()
      for i, image in pairs(images) do
        img.render(image.id)
      end
    end,
    { desc="Clear Images" }
    )
  '';

  keymaps = [
    {
      mode = "n";
      key = "<leader>i";
      action = "<cmd>ImageClear<cr>";
    }
    {
      mode = "n";
      key = "<leader>I";
      action = "<cmd>ImageRender<cr>";
    }
  ];
}
