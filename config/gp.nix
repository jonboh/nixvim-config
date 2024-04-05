{pkgs, ...}: {
  extraPlugins = [pkgs.vimExtraPlugins.gp-nvim];
  extraConfigLua = ''
    local chat_system_prompt = "You are a helpful AI assistant.\n\n"
            .. "The user provided the additional info about how they would like you to respond:\n\n"
            .. "- If you're unsure don't guess and say you don't know instead.\n"
            .. "- Don't elide any code from your output if the answer requires coding.\n"
            .. "- No yapping.\n"
    local config = {
      openai_api_key = { "rbw", "get", "platform.openai.com" },
      agents = {
        {
          name = "ChatGPT4",
          chat = true,
          command = false,
          model = { model = "gpt-4-1106-preview", temperature = 1.1, top_p = 1 },
          system_prompt = chat_system_prompt
        },
        {
          name = "ChatGPT3-5",
          chat = true,
          command = false,
          model = { model = "gpt-3.5-turbo-1106", temperature = 1.1, top_p = 1 },
          system_prompt = chat_system_prompt
        },
        {
          name = "CodeGPT4",
          chat = false,
          command = true,
          -- string with model name or table with model name and parameters
          model = { model = "gpt-4-1106-preview", temperature = 0.8, top_p = 1 },
          -- system prompt (use this to specify the persona/role of the AI)
          system_prompt = "You are an AI working as a code editor.\n\n"
            .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
            .. "START AND END YOUR ANSWER WITH:\n\n```",
        },
        {
          name = "CodeGPT3-5",
          chat = false,
          command = true,
          -- string with model name or table with model name and parameters
          model = { model = "gpt-3.5-turbo-1106", temperature = 0.8, top_p = 1 },
          -- system prompt (use this to specify the persona/role of the AI)
          system_prompt = "You are an AI working as a code editor.\n\n"
            .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
            .. "START AND END YOUR ANSWER WITH:\n\n```",
        }
      }
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
      mode = "n";
      key = "<C-g>z";
      action = "<cmd>GpNew<cr>";
      options = {desc = "New AI Chat";};
    }
    {
      mode = "v";
      key = "<C-g>z";
      action = ":'<,'>GpNew<cr>";
      options = {desc = "New AI Chat";};
    }
    {
      mode = ["n" "v"];
      key = "<C-g>n";
      action = "<cmd>GpNextAgent<cr>";
      options = {desc = "Next AI Agent";};
    }
    {
      mode = ["n" "v"];
      key = "<C-g>r";
      action = "<cmd>GpWhisper<cr>";
      options = {desc = "Whisper Transcript";};
    }
    {
      mode = "n";
      key = "<C-g>s";
      action = "<cmd>GpStop<cr>";
      options = {desc = "Stop response";};
    }
  ];
  extraPackages = [(pkgs.sox.override {enableLame = true;})];
}
