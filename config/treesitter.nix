{
  plugins.treesitter = {
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
  plugins.treesitter-context = {
    enable = true;
  };
}
