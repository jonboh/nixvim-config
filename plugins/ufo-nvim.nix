{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin rec {
  pname = "nvim-ufo";
  version = "nightly";
  src = fetchFromGitHub {
    owner = "kevinhwang91";
    repo = "nvim-ufo";
    rev = "a5390706f510d39951dd581f6d2a972741b3fa26";
    hash = "sha256-dzMlbzY8vyTo1t+EHqvzviiHPgWe7jCfAIQArwgozDs=";
  };
}
