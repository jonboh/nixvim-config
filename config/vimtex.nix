{pkgs, ...}: {
  plugins.vimtex = {
    enable = true;
    # full is needed for Neorg render-latex
    texlivePackage = pkgs.texlive.combined.scheme-full;
  };
  extraConfigVim = ''
    let g:vimtex_compiler_latexmk = {
        \ 'aux_dir' : 'build',
        \ 'out_dir' : 'build',
        \ 'callback' : 1,
        \ 'continuous' : 1,
        \ 'executable' : 'latexmk',
        \ 'hooks' : [],
        \ 'options' : [
        \   '-verbose',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
        \}
  '';
}
