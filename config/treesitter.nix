{
  plugins = {
    treesitter = {
      enable = true;
      settings = {
        incremental_selection = {
          enable = true;
          keymaps = {
            init_selection = "+";
            node_incremental = "+";
            node_decremental = "-";
          };
        };
        highlight = {
          enable = true;
          disable = ["csv"]; # csv highlight in nvim is better than treesitter
        };
      };
      nixvimInjections = true;
    };
    treesitter-context.enable = true;
  };
}
