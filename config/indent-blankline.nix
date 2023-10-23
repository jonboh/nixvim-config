{
  config = {
    plugins.indent-blankline =
      {
        enable = true;
      };
    options = {
      list = true;
      listchars = "space:⋅";
    };
    extraConfigLua = ''
      require("ibl").setup()
    '';
  };
}
