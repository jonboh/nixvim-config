{
  plugins = {
    treesitter = {
      enable = true;
      incrementalSelection = {
        enable = true;
        keymaps = {
          initSelection = "+";
          nodeIncremental = "+";
          nodeDecremental = "-";
        };
      };
      nixvimInjections = true;
    };
    treesitter-context.enable = true;
  };
}
