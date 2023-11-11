{ pkgs, ... }: {
  extraPlugins = [
    pkgs.vimExtraPlugins.ChatGPT-nvim
  ];
  extraConfigLua = ''
    require("chatgpt").setup({
       api_key_cmd = "cat /home/jonboh/.secrets/chatgpt.key",
          openai_params = {
            model = "gpt-3.5-turbo-16k",
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
