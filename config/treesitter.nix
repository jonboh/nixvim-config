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
      };
      nixvimInjections = true;
    };
    treesitter-context.enable = true;
  };
}
