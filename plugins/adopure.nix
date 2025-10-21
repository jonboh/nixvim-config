{
  lib,
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin rec {
  pname = "adopure-nvim";
  version = "v2.1.1";

  src = fetchFromGitHub {
    owner = "Willem-J-an";
    repo = "adopure.nvim";
    rev = "v2.1.1";
    hash = "sha256-vwolAocKKKvVeBc1bakpVW9yKlpu0iBy7UOs9hS2ihE=";
  };

  doCheck = false;
}
