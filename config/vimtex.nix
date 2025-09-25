{lib, ...}: {
  plugins.vimtex = {
    enable = true;
    settings = {
      view_method = "zathura";
      callback_progpath = lib.mkForce "nixvim";
    };
    zathuraPackage = null; # use system package. that is my fork
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
