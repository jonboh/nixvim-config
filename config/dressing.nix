{pkgs, ...}: {
  extraPlugins = [pkgs.vimPlugins.dressing-nvim];
  extraConfigLua = ''
    require("dressing").setup({})
  '';
}
