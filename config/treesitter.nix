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
        highlight.enable = true;
      };
      nixvimInjections = true;
    };
    treesitter-context.enable = true;
  };
}
