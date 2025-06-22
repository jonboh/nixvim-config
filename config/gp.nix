{pkgs, ...}: let
  new_chat_shortcut = "<C-g><C-c>";
  # NOTE: kind of hacky way to force the removal of these models
  droppedModels = ''
    {
      name = "CodeCopilot",
      disable=true
    },
    {
      name = "CodeGemini",
      disable=true
    },
    {
      name = "CodePerplexityMixtral",
      disable=true
    },
    {
      name = "CodeOllamaDeepSeek",
      disable=true
    },
    {
      name = "CodeClaude-3-Haiku",
      disable=true
    },
    {
      name = "CodeGPT35-P",
      disable=true
    },
    {
      name = "CodeGPT3-5",
      disable=true
    },
    {
      name = "CodeGPT4",
      disable=true
    },
    {
      name = "ChatOllama",
      disable=true
    },
    {
      name = "ChatLMStudio",
      disable=true
    },
    {
      name = "ChatPerplexityMixtral",
      disable=true
    },
    {
      name = "ChatClaude-3-Haiku",
      disable=true
    },
    {
      name = "ChatCopilot",
      disable=true
    },
    {
      name = "ChatGPT3-5",
      disable=true
    },
    {
      name = "ChatGPT4",
      disable=true
    },
    {
      name = "ChatGemini",
      disable=true
    },
  '';
in {
  extraPlugins = [pkgs.vimExtraPlugins.gp-nvim];
  # extraPlugins = [(pkgs.callPackage ../plugins/gp-nvim.nix {})];
  extraConfigLua = ''
    local chat_system_prompt = "You are a helpful AI assistant.\n\n"
            .. "The user provided the additional info about how they would like you to respond:\n\n"
            .. "- If you're unsure don't guess and say you don't know instead.\n"
            .. "- Don't elide any code from your output if the answer requires coding.\n"
            .. "- When writing math, use $<math>$ instead of \(<math>\)"
            .. "- No yapping.\n"
    local code_system_prompt = "You are an AI working as a code editor.\n\n"
            .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
            .. "START AND END YOUR ANSWER WITH:\n\n```"
    local config = {
      openai_api_key = { "pass-password", "platform.openai.com_API_Key" },
      agents = {
        {
          name = "DeepSeek7B",
          provider = "ollama",
          chat = true,
          command = false,
          model = {
            model = "deepseek-coder:6.7b",
          },
          system_prompt = chat_system_prompt
        },
        {
          name = "CodeDeepSeek7B",
          provider = "ollama",
          chat = false,
          command = true,
          model = {
            model = "deepseek-coder:6.7b",
          },
          system_prompt = code_system_prompt
        },
        {
          name = "Llama3",
          provider = "ollama",
          chat = true,
          command = false,
          model = {
            model = "llama3:8b",
          },
          system_prompt = chat_system_prompt
        },
        {
          name = "CodeLlama3",
          provider = "ollama",
          chat = false,
          command = true,
          model = {
            model = "llama3:8b",
          },
          system_prompt = chat_system_prompt
        },
        {
          name = "ChatGPT4.1-P",
          chat = true,
          command = false,
          model = { model = "gpt-4.1-2025-04-14", temperature = 1.1, top_p = 1 },
          system_prompt = chat_system_prompt
        },
        {
          name = "CodeGPT4.1-P",
          chat = false,
          command = true,
          -- string with model name or table with model name and parameters
          model = { model = "gpt-4.1-2025-04-14", temperature = 0.8, top_p = 1 },
          -- system prompt (use this to specify the persona/role of the AI)
          system_prompt = code_system_prompt
        },
        ${droppedModels}
      },
      chat_shortcut_respond = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g><C-g>" },
      chat_shortcut_delete = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>d" },
      chat_shortcut_stop = { modes = { "n", "i", "v", "x" }, shortcut = "<C-g>s" },
      chat_shortcut_new = { modes = { "n", "i", "v", "x" }, shortcut = "${new_chat_shortcut}" },
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
      key = "<C-g>V";
      action = "<cmd>GpChatNew vsplit<cr>";
      options = {desc = "Toggle AI Chat Vertical";};
    }
    {
      mode = ["n" "v"];
      key = "<C-g>H";
      action = "<cmd>GpChatNew split<cr>";
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
      key = "${new_chat_shortcut}";
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
