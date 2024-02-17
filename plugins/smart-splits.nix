{ lib, vimUtils, fetchFromGitHub }:

vimUtils.buildVimPlugin rec {
  pname = "smart-splits.nvim";
  version = "v1.2.4";

  src = fetchFromGitHub {
    owner = "mrjones2014";
    repo = "smart-splits.nvim";
    rev = "c8a9173d70cbbd1f6e4a414e49e31df2b32a1362";
    hash = "sha256-Q61B5opLqSP4bqE18ey/Qi0UCwbCPZ4gh/pcbLYbvkM=";
  };

  meta = with lib; {
    description =
      "🧠 Smart, seamless, directional navigation and resizing of Neovim + terminal multiplexer splits. Supports tmux, Wezterm, and Kitty. Think about splits in terms of up/down/left/right";
    homepage = "https://github.com/mrjones2014/smart-splits.nvim";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
    platforms = platforms.all;
  };
}
