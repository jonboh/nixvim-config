{pkgs, ...}: {
  extraPlugins = [pkgs.vimExtraPlugins.just-nvim-nxuv];
  extraConfigLua = ''
    require("just").setup({
        autoscroll_qf = false,
      })
  '';
  # NOTE: Alternative: https://github.com/chrisgrieser/nvim-justice?tab=readme-ov-file
}
