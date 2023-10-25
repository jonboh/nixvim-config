{ pkgs, ... }: {
  extraPlugins = [
    pkgs.vimExtraPlugins.ChatGPT-nvim
  ];
  extraConfigLua = ''
    require("chatgpt").setup()
  '';
  keymaps = [
    {
      mode = "n";
      key = "<A-s>";
      action = "<cmd>ChatGPT<CR>";
      options.desc = "Toggle ChatGPT";
    }
  ];

}
