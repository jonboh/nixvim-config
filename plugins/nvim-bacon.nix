{
  lib,
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin rec {
  pname = "nvim-bacon";
  version = "9310faab2ffc03a4b375ad20cab3191c96d612d3";

  src = fetchFromGitHub {
    owner = "Canop";
    repo = "nvim-bacon";
    rev = "9310faab2ffc03a4b375ad20cab3191c96d612d3";
    hash = "sha256-tOFXjq1FbZZ6bvkl3f5MbviB0m+q+28tr+QAtbTzPPs=";
  };

  meta = with lib; {
    description = "bacon's companion for neovim";
    homepage = "https://github.com/Canop/nvim-bacon";
    license = licenses.gpl3;
    maintainers = with maintainers; [];
    platforms = platforms.all;
  };
}
