{pkgs, ...}: {
  extraPlugins = [pkgs.vimPlugins.Coqtail];

  extraConfigVim = ''
    function CoqtailHookDefineMappings()
      imap <buffer> <S-Down> <Plug>RocqNext
      imap <buffer> <S-Left> <Plug>RocqToLine
      imap <buffer> <S-Up> <Plug>RocqUndo
      nmap <buffer> <S-Down> <Plug>RocqNext
      nmap <buffer> <S-Left> <Plug>RocqToLine
      nmap <buffer> <S-Up> <Plug>RocqUndo
    endfunction
  '';
}
