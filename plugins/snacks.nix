{
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin
rec {
  pname = "snacks.nvim";
  version = "ba848542e702dff305f14a61377169c52b1a7cc8";

  src = fetchFromGitHub {
    owner = "jonboh";
    repo = "snacks.nvim";
    rev = version;
    hash = "sha256-NsPQ4eS1B5+btg2Uvuhb4KFNUj5+KeQcKqxXOR8B6X8=";
  };
  doCheck = false;
}
