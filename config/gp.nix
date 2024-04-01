{pkgs, ...}: {
  extraPlugins = [pkgs.vimExtraPlugins.gp-nvim];
  extraConfigLua = ''
    local config = {
      openai_api_key = { "rbw", "get", "platform.openai.com" }
      }
    require("gp").setup(config)

    vim.api.nvim_create_user_command('GpReload', function()
      require("gp").setup(config)
      end,
      {})
  '';
  keymaps = [
    {
      mode = ["n" "v"];
      key = "<C-g>v";
      action = "<cmd>GpChatToggle vsplit<cr>";
      options = {desc = "Toggle AI Chat Vertical";};
    }
    {
      mode = ["n" "v"];
      key = "<C-g>h";
      action = "<cmd>GpChatToggle split<cr>";
      options = {desc = "Toggle AI Chat Horizontal";};
    }
    {
      mode = ["n" "v"];
      key = "<C-g>t";
      action = "<cmd>GpChatToggle tabnew<cr>";
      options = {desc = "Toggle AI Chat Horizontal";};
    }
    {
      mode = ["n"];
      key = "<C-g>f";
      action = "<cmd>GpChatFinder<cr>";
      options = {desc = "AI Chat finder";};
    }
    {
      mode = ["n" "v"];
      key = "<C-g>c";
      action = "<cmd>GpChatNew<cr>";
      options = {desc = "New AI Chat";};
    }
    {
      mode = ["n" "v"];
      key = "<C-g>n";
      action = "<cmd>GpNextAgent<cr>";
      options = {desc = "New AI Chat";};
    }
    {
      mode = ["n" "v"];
      key = "<C-g>r";
      action = "<cmd>GpWhisper<cr>";
      options = {desc = "Whisper Transcript";};
    }
  ];
  extraPackages = [(pkgs.sox.override {enableLame = true;})];
}
