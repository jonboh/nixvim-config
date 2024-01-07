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
    };
    treesitter-context.enable = true;
  };
}
