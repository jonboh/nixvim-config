{
  lib,
  vimUtils,
  fetchFromGitHub,
}:
vimUtils.buildVimPlugin rec {
  pname = "nvim-dap-rr";
  version = "v0.1.1";

  src = fetchFromGitHub {
    owner = "jonboh";
    repo = "nvim-dap-rr";
    rev = "v0.1.1";
    hash = "sha256-1WgES0gng74eNfTxJZksYoAFIYtuG3D/l/BEyt1o60w=";
  };

  meta = with lib; {
    description = "Dap configuration for the record and replay debugger. Supports Rust, C++ and C";
    homepage = "https://github.com/jonboh/nvim-dap-rr";
    license = licenses.mit;
    maintainers = with maintainers; [];
    mainProgram = "nvim-dap-rr";
    platforms = platforms.all;
  };
}
