{
  globals.mapleader = " ";
  globals.maplocalleader = "h";
  keymaps = [
    {
      mode = "t";
      key = "<Esc>";
      action = "<C-\\><C-n>";
      options = {
        desc = "Make Esc take you out of Terminal mode";
      };
    }
    {
      mode = "n";
      key = "<Esc>";
      action = "<cmd>nohls<cr><cmd>NoiceDismiss<cr><Esc>";
      options = {
        desc = "<Esc>, clear search highlight and dismiss Noice notifications";
      };
    }

    ## Clear space for leader
    {
      mode = "n";
      key = "<space>";
      action = "<nop>";
    }
    ## Using nav layer
    {
      mode = "n";
      key = "j";
      action = "<nop>";
    }
    {
      mode = "n";
      key = "k";
      action = "<nop>";
    }
    {
      mode = "n";
      key = "l";
      action = "<nop>";
    }
    {
      mode = "n";
      key = "h";
      action = "<nop>";
    }

    ## Search
    {
      mode = "n";
      key = "n";
      action = "nzzzv";
      options = {
        desc = "Center focus and open fold on next match";
      };
    }
    {
      mode = "n";
      key = "N";
      action = "Nzzzv";
      options = {
        desc = "Center focus and open fold on previos match";
      };
    }

    ## Navigation
    {
      mode = "n";
      key = "<C-Down>";
      action = "<cmd>copen<CR><cmd>cnext<CR>zz";
      options = {
        desc = "Go to next qf item";
      };
    }
    {
      mode = "n";
      key = "<C-Up>";
      action = "<cmd>copen<CR><cmd>cprev<CR>zz";
      options = {
        desc = "Go to prev qf item";
      };
    }
    {
      mode = "n";
      key = "<CS-O>";
      action = "<C-I>";
    }

    ## Windows
    {
      mode = "n";
      key = "<A-v>";
      action = "<C-W><C-v><C-W><C-l>";
      options = {
        desc = "Split vertically";
      };
    }
    {
      mode = "n";
      key = "<A-h>";
      action = "<C-W><C-s><C-W><C-j>";
      options = {
        desc = "Split horizontally";
      };
    }
    {
      mode = "n";
      key = "<A-q>";
      action = ":bd<CR>";
      options = {
        desc = "Close buffer";
      };
    }
    {
      mode = "n";
      key = "<A-x>";
      action = "<C-W>q";
      options = {
        desc = "Close window";
      };
    }
    {
      mode = "n";
      key = "<A-S-Left>";
      action = "<C-W>5<";
      options = {
        desc = "Resize left";
      };
    }
    {
      mode = "n";
      key = "<A-S-Right>";
      action = "<C-W>5>";
      options = {
        desc = "Resize right";
      };
    }
    {
      mode = "n";
      key = "<A-S-Up>";
      action = "<C-W>+";
      options = {
        desc = "Resize up";
      };
    }
    {
      mode = "n";
      key = "<A-S-Down>";
      action = "<C-W>-";
      options = {
        desc = "Resize down";
      };
    }

    {
      mode = "n";
      key = "<leader>r";
      action = ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>";
      options = {
        desc = "Substitute current word";
      };
    }
    {
      mode = "v";
      key = "<leader>r";
      action = "\"0y:%s/<C-r>0/<C-r>0/gI<Left><Left><Left>";
      options = {
        desc = "Substitute selected text";
      };
    }
    {
      mode = "v";
      key = "$";
      action = "$<Left>";
    }

    # clipboard
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
