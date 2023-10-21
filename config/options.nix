{
  config = {

    globals = {
      # Disable useless providers
      loaded_ruby_provider = 0; # Ruby
      loaded_perl_provider = 0; # Perl
      loaded_python_provider = 0; # Python 2
    };

    # TODO: add clipboard keymaps
    clipboard = {
      # Use system clipboard
      register = "unnamedplus";

      providers.xclip.enable = true;
    };

    options = {
      number = true;
      relativenumber = true;
      cursorline = true;

      errorbells = true;

      tabstop = 4;
      softtabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      smartindent = true;
      wrap = false;

      # navigation
      scrolloff = 8;

      # search
      hlsearch = true;
      incsearch = true;
      ignorecase = true;
      smartcase = true;

      # other
      colorcolumn = [ 80 100 ];
      signcolumn = "yes";
      termguicolors = true;
      fileformat = "unix";
      ff = "unix";
      # cmdheight = 1;
      winbar = "%f %m";

      # history and backup
      updatetime = 100;
      swapfile = false;
      backup = false;
      undofile = true;


      # folding
      foldmethod = "expr";
      foldexpr = "nvim_treesitter#foldexpr()";
      foldminlines = 3;
      foldenable = true;
      foldlevelstart = 9;



      # leader
      timeout = true;
      timeoutlen = 500;

      # grep
      grepprg = "rg --vimgrep";

    };
  };

}
