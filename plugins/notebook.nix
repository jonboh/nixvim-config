{
  lib,
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin rec {
  pname = "NotebookNavigator-nvim";
  version = "16fed604653aa9aa7c9c421536c6c92feef2bc38";
  src = fetchFromGitHub {
    owner = "jonboh";
    repo = "NotebookNavigator.nvim";
    rev = "16fed604653aa9aa7c9c421536c6c92feef2bc38";
    hash = "sha256-0kAF47Zbfyf6CsuK6ck1pXpwe0GB2D+Gld9SVEKkFYg=";
  };

  # src = fetchTree {
  #   path = /home/jonboh/devel/NotebookNavigator.nvim;
  #   type = "path";
  # };
}
