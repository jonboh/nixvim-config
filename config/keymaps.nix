{config, ...}: {
  globals.mapleader = " ";
  globals.maplocalleader = "h";
  keymaps = [
    # TODO: add invlist
    {
      mode = "t";
      key = "<Esc>";
      action = "<C-\\><C-n>";
      options = {desc = "Make Esc take you out of Terminal mode";};
    }
    {
      mode = "n";
      key = "<Esc>";
      action =
        if config.plugins.noice.enable
        then "<cmd>nohls<cr><cmd>NoiceDismiss<cr><Esc>"
        else "<cmd>nohls<cr>";
      options = {
        desc = "<Esc>, clear search highlight and dismiss Noice notifications";
      };
    }

    ## Make backspace remove characters in normal mode, in my layout S-Backspace=Delete so we have both directions
    {
      mode = "n";
      key = "<backspace>";
      action = "x";
    }
    {
      mode = "n";
      key = "<del>";
      action = "X";
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
    {
      mode = "n";
      key = "gzz";
      action = "zszH"; # zs (scroll horizontal to cursor) and zH (scorll half left)
    }

    ## Search
    {
      mode = "n";
      key = "n";
      action = "nzzzv";
      options = {desc = "Center focus and open fold on next match";};
    }
    {
      mode = "n";
      key = "N";
      action = "Nzzzv";
      options = {desc = "Center focus and open fold on previos match";};
    }

    ## Navigation
    {
      mode = "n";
      key = "<C-Down>";
      action = "<cmd>copen<CR><cmd>cnext<CR>zzzv";
      options = {desc = "Go to next qf item";};
    }
    {
      mode = "n";
      key = "<C-Up>";
      action = "<cmd>copen<CR><cmd>cprev<CR>zzzv";
      options = {desc = "Go to prev qf item";};
    }
    {
      mode = "n";
      key = "<CS-O>";
      action = "<C-I>";
    }

    ## Tabs
    {
      mode = "n";
      key = "<A-t>";
      action = "<cmd>tabnew<cr>";
      options = {desc = "Create new tab";};
    }
    {
      mode = "n";
      key = "<A-1>";
      action = "<cmd>1tabn<cr>";
      options = {desc = "Go to tab 1";};
    }
    {
      mode = "n";
      key = "<A-2>";
      action = "<cmd>2tabn<cr>";
      options = {desc = "Go to tab 2";};
    }
    {
      mode = "n";
      key = "<A-3>";
      action = "<cmd>3tabn<cr>";
      options = {desc = "Go to tab 3";};
    }
    {
      mode = "n";
      key = "<A-4>";
      action = "<cmd>4tabn<cr>";
      options = {desc = "Go to tab 3";};
    }
    {
      mode = "n";
      key = "<A-5>";
      action = "<cmd>5tabn<cr>";
      options = {desc = "Go to tab 4";};
    }
    {
      mode = "n";
      key = "<A-6>";
      action = "<cmd>6tabn<cr>";
      options = {desc = "Go to tab 6";};
    }
    {
      mode = "n";
      key = "<A-7>";
      action = "<cmd>7tabn<cr>";
      options = {desc = "Go to tab 7";};
    }
    {
      mode = "n";
      key = "<A-8>";
      action = "<cmd>8tabn<cr>";
      options = {desc = "Go to tab 8";};
    }
    {
      mode = "n";
      key = "<A-9>";
      action = "<cmd>9tabn<cr>";
      options = {desc = "Go to tab 8";};
    }
    {
      mode = "n";
      key = "<A-0>";
      action = "tablast";
    }

    ## Windows
    {
      mode = "n";
      key = "<A-v>";
      action = "<C-W><C-v><C-W><C-l>";
      options = {desc = "Split vertically";};
    }
    {
      mode = "n";
      key = "<A-h>";
      action = "<C-W><C-s><C-W><C-j>";
      options = {desc = "Split horizontally";};
    }
    {
      mode = "n";
      key = "<A-q>";
      action = ":bd<CR>";
      options = {desc = "Close buffer";};
    }
    {
      mode = "n";
      key = "<A-x>";
      action = "<C-W>q";
      options = {desc = "Close window";};
    }
    {
      mode = "n";
      key = "<A-backspace>";
      action = "<C-W>q";
      options = {desc = "Close window";};
    }
    {
      mode = "n";
      key = "<AS-Left>";
      action = "<C-W>H";
      options = {desc = "Move window Left";};
    }
    {
      mode = "n";
      key = "<AS-Down>";
      action = "<C-W>J";
      options = {desc = "Move window down";};
    }
    {
      mode = "n";
      key = "<AS-Up>";
      action = "<C-W>K";
      options = {desc = "Move window up";};
    }
    {
      mode = "n";
      key = "<AS-Right>";
      action = "<C-W>L";
      options = {desc = "Move window right";};
    }
    {
      mode = "n";
      key = "<leader>r";
      action = ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>";
      options = {desc = "Substitute current word";};
    }
    {
      mode = "v";
      key = "<leader>r";
      action = ''"0y:%s/<C-r>0/<C-r>0/gI<Left><Left><Left>'';
      options = {desc = "Substitute selected text";};
    }
    {
      mode = "v";
      key = "$";
      action = "$<Left>";
    }
  ];
}
