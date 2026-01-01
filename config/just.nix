{pkgs, ...}: {
  extraPlugins = [pkgs.vimExtraPlugins.just-nvim];
  extraConfigLua = ''
    require("just").setup({
        autoscroll_qf = false,
      })
  '';
}
