{pkgs, ...}: {
  extraPlugins = [pkgs.vimExtraPlugins.nvim-scrollbar];
  extraConfigLua = ''
    require("scrollbar").setup()
  '';
}
