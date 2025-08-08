{
  vimUtils,
  fetchFromGitHub,
}:
# some code with wrong spelling. with~/.local/share/nvim/site/spell/en.utf-8.add
vimUtils.buildVimPlugin
rec {
  pname = "spellwarn.nvim";
  version = "12734b47b008d912b4925c0bc2c1248eb534409d";

  src = fetchFromGitHub {
    owner = "ravibrock";
    repo = "spellwarn.nvim";
    rev = "12734b47b008d912b4925c0bc2c1248eb534409d";
    hash = "sha256-FYjWjL/i3hemDVP+xvJd7XTkQW3EbhMXQj0rlncxP+M=";
  };
}
