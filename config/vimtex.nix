{pkgs, ...}: {
  plugins.vimtex = {
    enable = true;
    # full is needed for Neorg render-latex
    texlivePackage = pkgs.texlive.combined.scheme-full;
  };
}
