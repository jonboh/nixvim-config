{pkgs, ...}: {
  extraPlugins = [
    pkgs.vimPlugins.vim-dadbod
    pkgs.vimPlugins.vim-dadbod-ui
    pkgs.vimPlugins.vim-dadbod-completion
  ];
}
