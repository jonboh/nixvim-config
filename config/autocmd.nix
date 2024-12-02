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
      pattern = ["nix" "markdown" "haskell"];
      command = "setlocal tabstop=2 shiftwidth=2";
    }
    {
      event = "FileType";
      pattern = "markdown";
      command = "setlocal conceallevel=2";
    }
    # Set markdown to wrap, it helps with devdocs
    {
      event = "FileType";
      pattern = "markdown";
      command = "setlocal wrap";
    }
    # Enable spellcheck for some filetypes
    {
      event = "FileType";
      pattern = ["tex" "latex" "markdown"];
      command = "setlocal spell spelllang=en";
    }
  ];
}
