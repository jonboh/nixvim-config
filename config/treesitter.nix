{
  plugins = {
    treesitter = {
      enable = true;
      settings = {
        incrementalSelection = {
          enable = true;
          keymaps = {
            initSelection = "+";
            nodeIncremental = "+";
            nodeDecremental = "-";
          };
        };
        highlight.enable = true;
      };
      nixvimInjections = true;
    };
    treesitter-context.enable = true;
  };
}
