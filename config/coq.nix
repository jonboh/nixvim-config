{pkgs, ...}: {
  extraPlugins = [pkgs.vimPlugins.Coqtail];

  extraConfigVim = ''
    function CoqtailHookDefineMappings()
      imap <buffer> <S-Down> <Plug>RocqNext <Plug>RocqJumpToEnd
      imap <buffer> <S-Left> <Plug>RocqToLine
      imap <buffer> <S-Up> <Plug>RocqUndo <Plug>RocqJumpToEnd
      nmap <buffer> <S-Down> <Plug>RocqNext <Plug>RocqJumpToEnd
      nmap <buffer> <S-Left> <Plug>RocqToLine
      nmap <buffer> <S-Up> <Plug>RocqUndo <Plug>RocqJumpToEnd
    endfunction
  '';
}
