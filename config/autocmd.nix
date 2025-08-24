{
  autoCmd = [
    # Open help in a vertical split
    {
      event = "FileType";
      pattern = "help";
      command = "wincmd L";
    }

    # Set indentation to 2 spaces for nix files
    {
      event = "FileType";
      pattern = ["nix" "markdown" "haskell" "xml" "json" "sql"];
      command = "setlocal tabstop=2 shiftwidth=2";
    }
    {
      event = "FileType";
      pattern = "julia";
      command = "setlocal formatoptions-=o";
    }
    {
      event = "FileType";
      pattern = "markdown";
      command = "setlocal conceallevel=1";
    }
    # Set markdown to wrap, it helps with devdocs
    {
      event = "FileType";
      pattern = "markdown";
      command = "setlocal wrap";
    }
    {
      event = ["BufRead" "BufNewFile"];
      pattern = "*.xacro";
      command = "setfiletype xml";
    }
    {
      event = ["BufRead" "BufNewFile"];
      pattern = "*.sdf";
      command = "setfiletype xml";
    }
  ];
}
