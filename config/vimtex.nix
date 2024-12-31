{
  pkgs,
  binname,
  lib,
  ...
}: {
  plugins.vimtex = {
    enable = true;
    # full is needed for Neorg render-latex
    texlivePackage = pkgs.texlive.combined.scheme-full;
    settings = {
      view_method = "zathura";
      callback_progpath = lib.mkForce "${binname}";
    };
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
    let g:vimtex_view_method = 'zathura'
    let g:vimtex_callback_progpath = '${binname}'
  '';
}
