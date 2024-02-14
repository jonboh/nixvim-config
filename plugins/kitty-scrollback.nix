{ lib
, vimUtils
, fetchFromGitHub
}:

vimUtils.buildVimPlugin {
  pname = "kitty-scrollback.nvim";
  version = "v4.0.3";

  src = fetchFromGitHub {
    owner = "mikesmithgh";
    repo = "kitty-scrollback.nvim";
    rev = "78dd609368aa20bd6fbd801cce73ea30787ebe21";
    hash = "sha256-RAqRIrKKaRoBVLTlI18hCHvGwUb/YVfIb3soNmyO24w=";
  };

  meta = with lib; {
    description = "😽 Open your Kitty scrollback buffer with Neovim. Ameowzing!";
    homepage = "https://github.com/mikesmithgh/kitty-scrollback.nvim";
    platforms = platforms.all;
  };
}

