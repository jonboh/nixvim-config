{
  plugins = {
    treesitter = {
      enable = true;
      settings = {
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
