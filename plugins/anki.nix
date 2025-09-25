{
  lib,
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin rec {
  pname = "anki-nvim";
  version = "2a30bb4307000ff1be542906292418c50d3e7261";

  src = fetchFromGitHub {
    owner = "rareitems";
    repo = "anki.nvim";
    rev = "2a30bb4307000ff1be542906292418c50d3e7261";
    hash = "sha256-R2hjCS3wAelBw/pElcqPv7xoeVpYPKG7PrO0D8rlmOg=";
  };
  doCheck = false;

  meta = with lib; {
    description = "Neovim plugin that allows creation of Anki cards directly from neovim ";
    homepage = "https://github.com/rareitems/anki.nvim";
    license = licenses.gpl3;
    maintainers = ["jonboh"];
  };
}
