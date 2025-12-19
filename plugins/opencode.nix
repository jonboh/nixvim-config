{
  lib,
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin rec {
  pname = "opencode.nvim";
  version = "bc42d98c8efb23022d32fde878b0c07018eb73a8";

  src = fetchFromGitHub {
    owner = "NickvanDyke";
    repo = "opencode.nvim";
    rev = "bc42d98c8efb23022d32fde878b0c07018eb73a8";
    hash = "sha256-exkPf3s+E3DxbQrswcnlVBYtd11TBNmTV8KSz/lcvAI=";
  };
  doCheck = false;
}
