{
  clipboard = {
    # Use system clipboard
    register = "";

    providers.xclip.enable = true;
  };
  keymaps = [
    {
      mode = "n";
      key = "gy";
      action = "\"+y";
      options = {
        desc = "Copy to system clipboard";
      };
    }
    {
      mode = "v";
      key = "gy";
      action = "\"+y";
      options = {
        desc = "Copy to system clipboard";
      };
    }
    {
      mode = "n";
      key = "gY";
      action = "\"+Y";
      options = {
        desc = "Copy to system clipboard";
      };
    }
    {
      mode = "v";
      key = "gY";
      action = "\"+Y";
      options = {
        desc = "Copy to system clipboard";
      };
    }
    {
      mode = "n";
      key = "gp";
      action = "\"+p";
      options = {
        desc = "Paste from system clipboard";
      };
    }
    {
      mode = "v";
      key = "gp";
      action = "\"+p";
      options = {
        desc = "Paste from system clipboard";
      };
    }
    {
      mode = "n";
      key = "gP";
      action = "\"+P";
      options = {
        desc = "Paste from system clipboard";
      };
    }
    {
      mode = "v";
      key = "gP";
      action = "\"+P";
      options = {
        desc = "Paste from system clipboard";
      };
    }
    {
      mode = "n";
      key = "<leader>d";
      action = "\"_d";
      options = {
        desc = "Delete into void register";
      };
    }
    {
      mode = "v";
      key = "<leader>d";
      action = "\"_d";
      options = {
        desc = "delete into void register";
      };
    }
    {
      mode = "n";
      key = "<leader>D";
      action = "\"_D";
      options = {
        desc = "Delete into void register";
      };
    }
    {
      mode = "v";
      key = "<leader>D";
      action = "\"_D";
      options = {
        desc = "Delete into void register";
      };
    }
    {
      mode = "n";
      key = "<leader>c";
      action = "\"_c";
      options = {
        desc = "Change without losing content of yank register";
      };
    }
    {
      mode = "v";
      key = "<leader>c";
      action = "\"_c";
      options = {
        desc = "Change without losing content of yank register";
      };
    }
    {
      mode = "n";
      key = "<leader>C";
      action = "\"_C";
      options = {
        desc = "Change without losing content of yank register";
      };
    }
    {
      mode = "v";
      key = "<leader>C";
      action = "\"_C";
      options = {
        desc = "Change without losing content of yank register";
      };
    }
    {
      mode = "v";
      key = "<leader>p";
      action = "\"_dP";
      options = {
        desc = "Paste into selection without losing content of yank register";
      };
    }
  ];
}
