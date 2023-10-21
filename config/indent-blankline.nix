{
  config = {
    plugins.indent-blankline = {
      enable = true;
      char = "▎";
      spaceCharBlankline = "";
      # TODO: fix context highlighting
      showCurrentContext = true;
      showCurrentContextStart = true;
      showTrailingBlanklineIndent = false;
    };
    options = {
      list = true;
      listchars = "space:⋅";
    };
  };
}
