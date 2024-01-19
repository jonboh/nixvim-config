{ pkgs, ... }: {
  extraPlugins = [
    pkgs.vimExtraPlugins.ChatGPT-nvim
    pkgs.vimExtraPlugins.nui-nvim
  ];
  extraConfigLua = ''
    require("chatgpt").setup({
       api_key_cmd = "cat /home/jonboh/.secrets/chatgpt.key",
          openai_params = {
            model = "gpt-4-1106-preview",
            max_tokens = 500,
          },
      })
  '';
  keymaps = [
    # TODO: add keybind to stop stream response
    {
      mode = "n";
      key = "<A-s>";
      action = "<cmd>ChatGPT<CR>";
      options.desc = "Toggle ChatGPT";
    }
  ];

}
