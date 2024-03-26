{
  plugins.image = {
    enable = true;

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
