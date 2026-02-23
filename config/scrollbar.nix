{pkgs, ...}: {
  extraPlugins = [pkgs.vimExtraPlugins.nvim-scrollbar-petertriho];
  extraConfigLua = ''
    require("scrollbar").setup()
  '';
}
