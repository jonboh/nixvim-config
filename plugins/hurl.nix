{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin rec {
  pname = "hurl.nvim";
  version = "16fed604653aa9aa7c9c421536c6c92feef2bc38";
  src = fetchFromGitHub {
    owner = "jellydn";
    repo = "hurl.nvim";
    rev = "ba2f77ce98cfbeafa55809bd36f360e65a15b952";
    hash = "sha256-h5BNp1FBpAFiBdoWznu2oPeMR3TZWTRNN4ZpQHmLwyo=";
  };
}
