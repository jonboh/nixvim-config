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
    rev = "34dc9b6f3bb72e5430e5307af006a73be814ae3e";
    hash = "sha256-8YI0caQNF9GyeumklCyE8YBeK3HOCrhy+sSROFcKHAk=";
  };

  # src = fetchTree {
  #   path = /home/jonboh/devel/NotebookNavigator.nvim;
  #   type = "path";
  # };
}
